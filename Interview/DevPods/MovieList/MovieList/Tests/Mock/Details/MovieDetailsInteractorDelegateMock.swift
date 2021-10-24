
import Shared
@testable import MovieList

final class MovieDetailsInteractorDelegateMock: MovieDetailsInteractorDelegate {
    
    var didCall_DidFetch: Bool = false
    var didCall_DidFailFetch: Bool = false

    
    func didFetch(movie: Movie) {
        didCall_DidFetch = true
    }
    
    func didFailFetch() {
        didCall_DidFailFetch = true
    }
}
