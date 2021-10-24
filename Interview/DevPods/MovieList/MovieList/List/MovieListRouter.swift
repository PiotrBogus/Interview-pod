
import Utils
import UIKit
import Shared

protocol MovieListRouterInterface {
    func showMovieDetails(on viewController: UIViewController, movie: Movie)
}

final class MovieListRouter: MovieListRouterInterface, Presentable {
    
    private let detailsFetcher: MovieDetailsAPIFetcher
    
    init(detailsFetcher: MovieDetailsAPIFetcher) {
        self.detailsFetcher = detailsFetcher
    }
    
    func showMovieDetails(on viewController: UIViewController, movie: Movie) {
        let movieDetailsViewController = MovieDetailsBuilder().build(detailsFetcher: detailsFetcher, movie: movie)
        
        push(viewController: movieDetailsViewController, on: viewController)
    }
}
