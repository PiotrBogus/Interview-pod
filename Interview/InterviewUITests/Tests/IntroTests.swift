
@testable import Interview
import Utils
import XCTest

final class IntroTests: BaseTest {
    
    private lazy var intro = pathsFactory.intro
    
    func test_PresentMovieList() {
        intro.enterMovieList()
    }
}
