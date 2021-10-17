
import XCTest

protocol SnapshotValue {
    static var id: String { get }
    var name: String { get }
}

protocol SnapShooter {
    func setUp()
    func tearDown()
    func initialize(name: String, language: String)
    func takeSnapshot<Name: SnapshotValue>(name: Name, ignoredElements: [XCUIElement])
}
