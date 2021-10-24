
import Shared
@testable import MovieList

final class MovieDetailsInteractorMock: MovieDetailsInteractorInterface {
    
    weak var delegate: MovieDetailsInteractorDelegate?
    
    private let okResponse: Bool
        
    init(okResponse: Bool = false) {
        self.okResponse = okResponse
    }

    func fetchDetails(for id: String) {
        okResponse ? delegate?.didFetch(movie: .fixture) : delegate?.didFailFetch()
    }
}
