
import Shared
@testable import MovieList

final class MovieListInteractorMock: MovieListInteractorInterface {
    
    weak var delegate: MovieListInteractorDelegate?
    
    private let okResponse: Bool
        
    init(okResponse: Bool = false) {
        self.okResponse = okResponse
    }

    func fetchMovieList(for language: String) {
        okResponse ? delegate?.didFetch(movieList: MovieList.fixture) : delegate?.didFailFetchMovieList()
    }
    
    func fetchMoreMovies(for searchedPhrase: String, page: Int) {
        okResponse ? delegate?.didFetchMore(movieList: MovieList.fixture) : delegate?.didFailFetchMoreMovie()
    }
}
