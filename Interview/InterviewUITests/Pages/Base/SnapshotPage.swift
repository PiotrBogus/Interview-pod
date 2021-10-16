
import Foundation
import XCTest

protocol SnapshotPage: Page {
    var snapShooter: SnapShooter? { get }

    var ignoredElements: [XCUIElement] { get }
}

extension SnapshotPage {

    var ignoredElements: [XCUIElement] { [] }
    private var currentLanguage: String { Locale.current.languageCode ?? "en" }

    @discardableResult
    func initializeSnapshot<Name: SnapshotValue>(of type: Name.Type, name: String) -> Self {
        snapShooter?.initialize(
            name: "\(type.id) - \(name.substring(regex: #"test_([_\w]+)"#)!.replacingOccurrences(of: "test_", with: ""))", 
            language: currentLanguage
        )

        return self
    }

    @discardableResult
    func takeSnapshot<Name: SnapshotValue>(name: Name) -> Self {
        snapShooter?.takeSnapshot(name: name, ignoredElements: ignoredElements)

        return self
    }
}
