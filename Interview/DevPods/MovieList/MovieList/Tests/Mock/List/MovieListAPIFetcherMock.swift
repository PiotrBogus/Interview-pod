
import Foundation
import MovieList
import Shared

final class MovieListAPIFetcherMock: MovieListAPIFetcher {
    
    
    private let okResponse: Bool
    
    init(okResponse: Bool = false) {
        self.okResponse = okResponse
    }
    
    func fetchList(for searchedPhrase: String, page: Int, completion: @escaping MovieListFetchCompletion) {
        okResponse ? completion(.success(MovieList.fixture)) : completion(.failure(.jsonParseError))
    }
}
