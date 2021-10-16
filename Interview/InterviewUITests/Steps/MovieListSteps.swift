
import XCTest

final class MovieListSteps: Steps {

    let factory: PageFactory
    var page: MovieListPage { factory.movieList }

    init(factory: PageFactory) {
        self.factory = factory
    }

    @discardableResult
    func verifyState(file: StaticString = #file, line: UInt = #line) -> Self {
        page.waitForAppearance(file: file, line: line)

        return self
    }
    
    @discardableResult
    func tapCell(at index: Int, file: StaticString, line: UInt) -> Self {
        page
            .cell(at: index).tap()
        
        return self
    }
}
