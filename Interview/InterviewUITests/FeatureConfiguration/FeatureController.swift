
import Utils
import XCTest
import Shared

final class FeatureController {

    let server = LocalhostServer()

    private var launchArguments = [UITestLaunchArguments.uiTestEnabled, .animationsDisabled]
    private var features: [FeatureConfiguration] = UITestConstants.features

    weak var app: XCUIApplication!

    init() {}

    func setUp(on app: XCUIApplication) {
        self.app = app

        setUpServer()
        setUpLaunchArguments()
        setUpFeatures()
    }

    func tearDown(for test: XCTestCase) {
        tearDownServer()
    }

    @discardableResult
    func update(launchArguments arguments: [UITestLaunchArguments]) -> Self {
        launchArguments.removeAll(where: arguments.contains)
        launchArguments.append(contentsOf: arguments)

        return self
    }

    @discardableResult
    func update(features: [FeatureConfiguration]) -> Self {
        self.features.removeAll(where: features.contains)
        self.features.append(contentsOf: features)

        return self
    }

    @discardableResult
    func disable(features: [FeatureConfiguration]) -> Self {
        self.features.removeAll(where: features.contains)

        return self
    }

    func contains(feature: FeatureConfiguration) -> Bool {
        features.contains(feature)
    }

    private func setUpServer() {
        server.start()

        features.map(\.api) |> forEach(forEach(server.add))
    }

    private func setUpLaunchArguments() {
        launchArguments.map(\.rawValue).forEach { app.launchArguments.append($0) }

        app.launchEnvironment[UITestLaunchArguments.mockupUrl.rawValue] = server.url
    }

    private func setUpFeatures() {
        features.map(\.configuration).forEach { configs in
            configs.forEach { key, value in app[launchEnvironment: key] = value }
        }
    }

    private func tearDownServer() {
        server.stop()
    }
}
