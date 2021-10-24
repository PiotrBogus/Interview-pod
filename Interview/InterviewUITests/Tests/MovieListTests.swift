
@testable import Interview
import UITestsCore
import Utils
import XCTest

final class MovieListTests: LegacyBaseTest {
    
    override var commonServerConfiguration: [MockAPI] {
        [
            .movieList
        ]
    }
    
    private lazy var intro = pathsFactory.intro
    private lazy var movieList = pathsFactory.movieList
    
    func test_MovieList() {
        intro
            .enterMovieList()
        
        movieList.searchMovie()
        
        sleep(30)
    }
}
