
import Utils
import Shared
import XCTest

class LegacyBaseTest: XCTestCase {

    var mockupServer: LocalhostServer!
    var app: XCUIApplication!
    var launchArguments: [UITestLaunchArguments] { [.uiTestEnabled, .animationsDisabled, .legacyConfigSystem] }
    var featuresConfiguration: [Feature: Bool] = [:]

    private let mockupServerDefaultConfiguration: [MockAPI] = []

    var commonServerConfiguration: [MockAPI] { [] }

    var testServerConfiguration: [String: [MockAPI]] { [:] }

    let trackingLogFilePath = FileManager.default.temporaryDirectory.appendingPathComponent("tracking_test_\(NSUUID().uuidString).plist").path


    var currentLanguage: String { Locale.current.languageCode ?? "en" }

    var snapShooter: SnapShooter? { nil }

    var pathsFactory: PathsFactory { factory }
    private lazy var factory = PathsFactory(
        app: app,
        test: self,
        snapShooter: snapShooter,
        mockupServer: mockupServer
    )

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()

        mockupServer = LocalhostServer()
        mockupServer.start()
        setUpMockupServerDefaultState()

        for launchArgument in launchArguments {
            app.launchArguments.append(launchArgument.rawValue)
        }

        updateFeaturesConfiguration()
        updateLaunchEnvironment()

        app.launchEnvironment[UITestLaunchArguments.mockupUrl.rawValue] = mockupServer.url


        app.launch()

        snapShooter?.setUp()
    }

    override func tearDown() {
        snapShooter?.tearDown()

        mockupServer?.stop()

        if testRun?.hasSucceeded == true {
            try? FileManager.default.removeItem(atPath: trackingLogFilePath)
        }

        super.tearDown()
    }

    func setUpSnapShooter() {}

    func tearDownSnapShooter() {}

    func updateFeaturesConfiguration() {}

    func updateLaunchEnvironment() {
        featuresConfiguration.forEach { app[launchEnvironment: $0] = $1 }
    }

    func configurationFilter<T: TestCaseConfiguration>(_: T.Type) -> [T] {
        T.allCases.filter(contains)
    }

    func configurationAPIMapper<T: TestCaseAPIConfiguration>(_: T.Type) -> [MockAPI] {
        T.self |> configurationFilter >>> map(\.api) >>> flatMap(identity)
    }

    func contains<T: TestCaseConfiguration>(_ config: T) -> Bool {
        name.contains(config.rawValue.capitalizedFirstLetter)
    }

    func contains<T: TestCaseConfiguration>(_ configs: [T]) -> Bool {
        configs.contains(where: contains)
    }

    private func setUpMockupServerDefaultState() {
        mockupServerDefaultConfiguration.forEach(addFilesToMockupServer)
        commonServerConfiguration.forEach(addFilesToMockupServer)

        if let config = testServerConfiguration.first(where: { name.contains($0.key) }) {
            config.value.forEach(addFilesToMockupServer)
        }
    }

    private func addFilesToMockupServer(mockApi: MockAPI) {
        mockApi.files.forEach(mockupServer.add)
    }
}
