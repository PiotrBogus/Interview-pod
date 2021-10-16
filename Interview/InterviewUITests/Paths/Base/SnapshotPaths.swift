
import XCTest

protocol SnapshotPaths: Paths where StepsType: SnapshotSteps {
    var testName: String { get }
}

extension SnapshotPaths {

    var testName: String { factory.test.name }

    @discardableResult
    func initializeSnapshot() -> Self {
        steps
            .initializeSnapshot(name: testName)

        return self
    }
}
