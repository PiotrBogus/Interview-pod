
import XCTest

final class IntroSteps: Steps {

    let factory: PageFactory
    var page: IntroPage { factory.intro }
    
    private var movieList: MovieListPage { factory.movieList }

    init(factory: PageFactory) {
        self.factory = factory
    }

    @discardableResult
    func tapEnterButton(file: StaticString, line: UInt) -> Self {
        page
            .waitForAppearance(file: file, line: line)
            .tap(\.enterButton)

        return self
    }
    
    @discardableResult
    func tapWebsiteButton(file: StaticString, line: UInt) -> Self {
        page
            .waitForAppearance(file: file, line: line)
            .tap(\.websiteButton)

        return self
    }
    
    @discardableResult
    func verifyMovieListAppeard(file: StaticString, line: UInt) -> Self {
        movieList
            .waitForAppearance(file: file, line: line)
        
        return self
    }
}
