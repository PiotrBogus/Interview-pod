
import XCTest

private let ids = ElementIdentifiers.MovieList.self

final class MovieListPage: Page {
    
    func cell(at index: Int) -> XCUIElement { app[element: ids.cell(index: 1)] }

    let app: XCUIApplication
    let id = ids.view.id
    init(app: XCUIApplication) {
        self.app = app
    }
}
