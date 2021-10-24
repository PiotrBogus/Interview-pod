
import UIKit
import Shared
@testable import MovieList

final class MovieListRouterMock: MovieListRouterInterface {
    
    var didCallShowMovieDetails: Bool = false

    func showMovieDetails(on viewController: UIViewController, movie repo: Movie) {
        didCallShowMovieDetails = true
    }
}
