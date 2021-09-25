
import XCTest
import UIKit
@testable import Interview

final class IntroViewPresenterTests: XCTestCase {

    func testShowOMDBWebsite() {
        let router = IntroViewRouterMock()
        let introViewPresenter = IntroViewPresenter(router: router)
        introViewPresenter.showOMDBWebsite()
        
        XCTAssertTrue(router.didCallOpenOMDBWebsite)
    }
    
    func testShowMovieList() {
        let router = IntroViewRouterMock()
        let introViewPresenter = IntroViewPresenter(router: router)
        introViewPresenter.showMovieList(on: UIViewController())
        
        XCTAssertTrue(router.didCallOpenMovieList)
    }
}
