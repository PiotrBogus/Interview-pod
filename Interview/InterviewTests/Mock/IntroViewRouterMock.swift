
import UIKit
@testable import Interview

final class IntroViewRouterMock: IntroViewRouterInterface {

    var didCallOpenMovieList: Bool = false
    var didCallOpenOMDBWebsite: Bool = false

    func openMovieList(on viewController: UIViewController) {
        didCallOpenMovieList = true
    }

    func openOMDBWebsite() {
        didCallOpenOMDBWebsite = true
    }
}
