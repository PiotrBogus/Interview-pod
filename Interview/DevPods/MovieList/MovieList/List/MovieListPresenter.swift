
import Foundation
import Shared
import UIKit

protocol MovieListPresenterDelegate: AnyObject {
    func didLoad(movieList: MovieList)
    func didLoadMore(movies: [Movie])
    func didFailFetchMovieList()
}

protocol MovieListPresenterInterface {
    var delegate: MovieListPresenterDelegate? { get set }

    func loadMovieList(for searchedPhase: String)
    func loadMoreMovies(for searchedPhrase: String, page: Int)
    func showDetails(for movie: Movie, on viewController: UIViewController)
}

final class MovieListPresenter: MovieListPresenterInterface {
    
    weak var delegate: MovieListPresenterDelegate?
    
    private let interactor: MovieListInteractorInterface
    private let router: MovieListRouterInterface
    
    init(interactor: MovieListInteractorInterface, router: MovieListRouterInterface) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadMovieList(for searchedPhrase: String) {
        interactor.fetchMovieList(for: searchedPhrase)
    }
    
    func loadMoreMovies(for searchedPhrase: String, page: Int) {
        interactor.fetchMoreMovies(for: searchedPhrase, page: page)
    }
    
    func showDetails(for movie: Movie, on viewController: UIViewController) {
        router.showMovieDetails(on: viewController, movie: movie)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    
    func didFetch(movieList: MovieList) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLoad(movieList: movieList)
        }
    }
    
    func didFetchMore(movieList: MovieList) {
        DispatchQueue.main.async { [ weak self] in
            self?.delegate?.didLoadMore(movies: movieList.movies)
        }
    }
    
    func didFailFetchMovieList() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didFailFetchMovieList()
        }
    }
    
    func didFailFetchMoreMovie() {}
}
