
import XCTest

protocol SnapshotSteps: Steps where PageType: SnapshotPage {
    associatedtype SnapshotName: SnapshotValue
}

extension SnapshotSteps {

    private var isSnapshotAllowed: Bool {
        factory.snapshotController?.isAllowed(page: page, in: factory) ?? true
    }

    @discardableResult
    func initializeSnapshot(name: String) -> Self {
        guard isSnapshotAllowed else { return self }

        page.initializeSnapshot(of: SnapshotName.self, name: name)

        return self
    }

    @discardableResult
    func takeSnapshot(_ name: SnapshotName) -> Self {
        guard isSnapshotAllowed else { return self }

        page.takeSnapshot(name: name)

        return self
    }
}
