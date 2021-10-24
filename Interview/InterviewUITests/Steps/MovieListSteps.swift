
import XCTest

final class MovieListSteps: Steps {

    let factory: PageFactory
    var page: MovieListPage { factory.movieList }
    
    private var keyboardPage: KeyboardPage { factory.keyboard }
    
    init(factory: PageFactory) {
        self.factory = factory
    }
    
    @discardableResult
    func tapCell(at index: Int, file: StaticString, line: UInt) -> Self {
        page
            .waitForAppearance(file: file, line: line)
            .cell(at: index).tap()
        
        return self
    }
    
    @discardableResult
    func fillSearchField(with searchedPhrase: String, file: StaticString, line: UInt) -> Self {
        page
            .tap(\.searchField)
        
        keyboardPage
            .waitForAppearance(file: file, line: line)
            .type(text: searchedPhrase, file: file, line: line)
            .tapReturn()

        return self
    }
}
