
import Foundation
import XCTest

final class SharedWebCredentialPage: InterruptiblePage {

    let id = ""
    let test: XCTestCase
    let app: XCUIApplication

    init(app: XCUIApplication, test: XCTestCase) {
        self.app = app
        self.test = test
    }

    func tapNotNowButtonIfNeeded(file: StaticString, line: UInt) {
        monitorInterruption { _ in false }
    }
}

private extension XCUIElement {

    var notNowButton: XCUIElement { buttons.element(boundBy: 0) }
    var okButton: XCUIElement { buttons.element(boundBy: 1) }
}
