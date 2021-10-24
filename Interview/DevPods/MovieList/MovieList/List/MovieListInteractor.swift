
import Foundation
import Shared
import Combine

protocol MovieListInteractorDelegate: AnyObject {
    func didFetch(movieList: MovieList)
    func didFetchMore(movieList: MovieList)
    func didFailFetchMovieList()
    func didFailFetchMoreMovie()
}

protocol MovieListInteractorInterface {
    var delegate: MovieListInteractorDelegate? { get set }
    
    func fetchMovieList(for searchedPahse: String)
    func fetchMoreMovies(for searchedPhrase: String, page: Int)
}

final class MovieListInteractor: MovieListInteractorInterface {
    
    weak var delegate: MovieListInteractorDelegate?

    private let apiListFetcher: MovieListAPIFetcher
    private var cancelables: [AnyCancellable] = []
    
    init(apiListFetcher: MovieListAPIFetcher) {
        self.apiListFetcher = apiListFetcher
    }
    
    func fetchMovieList(for searchedPhrase: String) {
        let publisher = apiListFetcher.fetchList(for: searchedPhrase, page: 1) { [weak self] result in
            guard let movieList = try? result.get() else {
                self?.delegate?.didFailFetchMovieList()
                return
            }
            
            self?.delegate?.didFetch(movieList: movieList)
        }
        publisher?.store(in: &cancelables)
    }
    
    func fetchMoreMovies(for searchedPhrase: String, page: Int) {
        let publisher = apiListFetcher.fetchList(for: searchedPhrase, page: page) { [weak self] result in
            guard let movieList = try? result.get() else {
                self?.delegate?.didFailFetchMoreMovie()
                return
            }
            
            self?.delegate?.didFetchMore(movieList: movieList)
        }
        
        publisher?.store(in: &cancelables)
    }
}
