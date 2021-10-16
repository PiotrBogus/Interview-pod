
import XCTest

protocol Factory {

    var test: XCTestCase { get }
}

extension Factory {

    private var baseTest: BaseTest? { test as? BaseTest }

    var snapshotController: SnapshotController? { baseTest?.snapshotController }

    func contains(feature: FeatureConfiguration) -> Bool {
        baseTest?.featureController.contains(feature: feature) ?? false
    }
}

extension PageFactory: Factory {}

extension StepsFactory: Factory {}

extension PathsFactory: Factory {}
