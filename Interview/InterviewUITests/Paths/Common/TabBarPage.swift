
import XCTest

private let ids = ElementIdentifiers.TabBar.self

final class TabBarPage: Page {

    let app: XCUIApplication
    let id = "id" // ids.search.id

//    var optionTab: XCUIElement { app.tabBars[element: ids.option]

    init(app: XCUIApplication) {
        self.app = app
    }
}
