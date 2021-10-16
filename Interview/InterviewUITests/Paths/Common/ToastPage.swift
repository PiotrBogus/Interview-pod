
import Utils
import XCTest

final class ToastPage: Page {

    let id = ElementIdentifiers.Generic.toastNotification.id
    let app: XCUIApplication
    let type: XCUIElement.ElementType = .other

    init(app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func waitForDisappearance(timeout: TimeInterval = .timeout, file: StaticString, line: UInt) -> Self {
        if screen.exists {
            screen.verify(.notExists, timeout: timeout, file: file, line: line)
        }

        return self
    }
}
