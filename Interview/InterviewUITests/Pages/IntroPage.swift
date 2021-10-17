
import XCTest

private let ids = ElementIdentifiers.Intro.self

final class IntroPage: Page {
    
    var enterButton: XCUIElement { app[element: ids.enterButton] }
    var websiteButton: XCUIElement { app[element: ids.websiteButton] }

    let app: XCUIApplication
    let id = ids.view.id
    init(app: XCUIApplication) {
        self.app = app
    }
}
