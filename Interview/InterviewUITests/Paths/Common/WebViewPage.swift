
import XCTest

final class WebViewPage: Page {

    let id = "icOpenInBrowser"
    let type = XCUIElement.ElementType.button
    let app: XCUIApplication

    var backButton: XCUIElement { app.navigationBars.lastMatch.buttons.firstMatch }

    init(app: XCUIApplication) {
        self.app = app
    }
}
