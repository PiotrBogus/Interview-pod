
import XCTest

protocol ActionSheetPage: Page {}

extension ActionSheetPage {

    var id: String { "" }
    var type: XCUIElement.ElementType { .sheet }
    var buttons: XCUIElementQuery { screen.buttons }
}
