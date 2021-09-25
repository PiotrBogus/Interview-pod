
import UIKit

protocol IntroViewRouterInterface {
    
    func openMovieList(on viewController: UIViewController)
    func openOMDBWebsite()
}

final class IntroViewRouter: IntroViewRouterInterface {

    private let movieListIntegration = MovieListIntegration()
    
    func openMovieList(on viewController: UIViewController) {
        movieListIntegration.presentMovieList(on: viewController)
    }
    
    func openOMDBWebsite() {
        guard let url = URL(string: .omdbURL)  else { return }
        
        UIApplication.shared.open(url)
    }
}
