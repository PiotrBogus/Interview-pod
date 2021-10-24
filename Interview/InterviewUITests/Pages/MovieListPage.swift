
import XCTest

private let ids = ElementIdentifiers.MovieList.self

final class MovieListPage: Page {
    
    var searchField: XCUIElement { app[element: ids.searchBar] }
    var collectionView: XCUIElement { app.collectionViews.firstMatch }
    func cell(at index: Int) -> XCUIElement { app[element: ids.cell(index: 1)] }

    let app: XCUIApplication
    let id = ids.view.id
    init(app: XCUIApplication) {
        self.app = app
    }
}
