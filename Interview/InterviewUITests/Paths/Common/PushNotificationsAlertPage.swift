
import XCTest

final class PushNotificationsAlertPage: InterruptiblePage {

    let id = ""
    let test: XCTestCase
    let app: XCUIApplication

    init(app: XCUIApplication, test: XCTestCase) {
        self.app = app
        self.test = test
    }

    func allowIfNeeded(file: StaticString, line: UInt) {
        monitorInterruption { element in
            let allowButton = element.buttons.element(boundBy: 1)

            if allowButton.waitForExistence(timeout: .timeout) {
                allowButton.tap()

                return true
            } else {
                return false
            }
        }

        app.tap()
    }
}
