
import Foundation
import Shared
import Networking
import MovieList
import Combine

final class MovieDetailsAPIFetcherIntegration: MovieDetailsAPIFetcher {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient(baseURL: .baseURL)) {
        self.apiClient = apiClient
    }
    
    func fetchDetails(for id: String) -> AnyPublisher<Movie, NetworkRequestError> {
        return apiClient.dispatch(MovieDetailsRequest(id: id))
    }    
}

struct MovieDetailsRequest: HTTPRequest {    
    typealias ReturnType = Movie
    
    let path: String = "/"
    var queryParams: HTTPQueryParams? {[
        "apikey": apiKey,
        "i": id
    ]}
    
    private let apiKey: String
    private let id: String
    
    init(apiKey: String = .apiKey, id: String) {
        self.apiKey = apiKey
        self.id = id
    }
}
