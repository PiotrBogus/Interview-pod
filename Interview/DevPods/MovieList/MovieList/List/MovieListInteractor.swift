
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
        apiListFetcher.fetchList(for: searchedPhrase, page: 1)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    self?.delegate?.didFetch(movieList: movies)
                }).store(in: &cancelables)
    }
    
    func fetchMoreMovies(for searchedPhrase: String, page: Int) {
        apiListFetcher.fetchList(for: searchedPhrase, page: page)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in                    
                    self?.delegate?.didFetchMore(movieList: movies)
                }).store(in: &cancelables)
    }
}
