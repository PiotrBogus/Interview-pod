
import Utils
import XCTest

class BaseTest: XCTestCase {

    var snapShooter: SnapShooter? { snapshotController?.snapShooter }
    lazy var snapshotController = makeSnapshotController()

    var pathsFactory: PathsFactory { factory }
    private lazy var factory = PathsFactory(
        app: app,
        test: self,
        snapShooter: snapShooter,
        mockupServer: featureController.server
    )

    private(set) lazy var app = XCUIApplication()
    let featureController = FeatureController()

    override func setUp() {
        super.setUp() 

        continueAfterFailure = false

        setUpCustomFeatures(on: featureController)
        featureController.setUp(on: app)

        app.launch()

        setupSnapshots()
    }

    override func tearDown() {
        snapShooter?.tearDown()

        featureController.tearDown(for: self)

        super.tearDown()
    }

    func setUpCustomFeatures(on controller: FeatureController) {}

    func makeSnapshotController() -> SnapshotController? { nil }

    private func setupSnapshots() {
        guard let snapShooter = snapShooter else { return }

        featureController.disable(features: [])

        snapShooter.setUp()
    }

    // MARK: Configuration Utils

    func contains<T: TestCaseConfiguration>(_ config: T) -> Bool {
        name.contains(config.rawValue.capitalizedFirstLetter)
    }

    func contains<T: TestCaseConfiguration>(_ configs: [T]) -> Bool {
        configs.contains(where: contains)
    }
}
