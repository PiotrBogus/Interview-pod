
import UIKit
import Utils

protocol IntroViewPresenterInterface {
    func showOMDBWebsite()
    func showMovieList(on viewController: UIViewController)
}

final class IntroViewPresenter: IntroViewPresenterInterface {
    
    private let router: IntroViewRouterInterface
    
    init(router: IntroViewRouterInterface) {
        self.router = router
    }
    
    func showOMDBWebsite() {
        router.openOMDBWebsite()
    }
    
    func showMovieList(on viewController: UIViewController) {
        router.openMovieList(on: viewController)
    }
}
