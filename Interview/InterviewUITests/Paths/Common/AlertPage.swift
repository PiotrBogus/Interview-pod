
import XCTest

protocol AlertPage: Page {}

extension AlertPage {

    var id: String { "" }
    var type: XCUIElement.ElementType { .alert }
    var buttons: XCUIElementQuery { screen.buttons }
}
