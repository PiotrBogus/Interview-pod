
import Foundation
import Shared
import Networking
import MovieList
import Combine

final class MovieListAPIFetcherIntegration: MovieListAPIFetcher {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient(baseURL: BaseUrlBuilder().baseURL)) {
        self.apiClient = apiClient
    }
    
    func fetchList(for searchedPhrase: String, page: Int) -> AnyPublisher<MovieList, NetworkRequestError> {
        return apiClient.dispatch(MovieListRequest(searchedPhrase: searchedPhrase, page: page))
    }
}

struct MovieListRequest: HTTPRequest {    
    typealias ReturnType = MovieList
    let path: String = "/"
    var queryParams: HTTPQueryParams? {[
        "apikey": apiKey,
        "type": "movie",
        "s": searchedPhrase,
        "page": String(page)
    ]}
    
    private let apiKey: String
    private let searchedPhrase: String
    private let page: Int
    
    init(
        apiKey: String = .apiKey,
        searchedPhrase: String,
        page: Int
    ) {
        self.apiKey = apiKey
        self.searchedPhrase = searchedPhrase
        self.page = page
    }
}
