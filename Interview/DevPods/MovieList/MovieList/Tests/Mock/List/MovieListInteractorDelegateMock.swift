
import Shared
@testable import MovieList

final class MovieListInteractorDelegateMock: MovieListInteractorDelegate {
    
    var didCall_DidFetch: Bool = false
    var didCall_DidFailFetchMovieList: Bool = false
    var didCall_DidFetchMore: Bool = false
    var didCall_DidFailFetchMoreMovie: Bool = false
    
    func didFetch(movieList: MovieList) {
        didCall_DidFetch = true
    }
    
    func didFailFetchMovieList() {
        didCall_DidFailFetchMovieList = true
    }
    
    func didFetchMore(movieList: MovieList) {
        didCall_DidFetchMore = true
    }
    
    func didFailFetchMoreMovie() {
        didCall_DidFailFetchMoreMovie = true
    }
    
}
