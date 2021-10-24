
import Foundation
import MovieList
import Shared

final class MovieDetailsAPIFetcherMock: MovieDetailsAPIFetcher {
    
    private let okResponse: Bool
    
    init(okResponse: Bool = false) {
        self.okResponse = okResponse
    }
    
    func fetchDetails(for id: String, completion: @escaping MovieDetailsFetchCompletion) {
        okResponse ? completion(.success(Movie.fixture)) : completion(.failure(.jsonParseError))
    }
}
