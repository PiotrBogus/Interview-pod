
import Foundation
import Shared
import Networking
import MovieList
import Combine

final class MovieListAPIFetcherIntegration: MovieListAPIFetcher {

    private let endpoint = "/"
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = DefaultNetworkingService(baseURL: BaseUrlBuilder().baseURL)) {
        self.networkingService = networkingService
    }
    
    func fetchList(for searchedPhrase: String, page: Int, completion: @escaping MovieListFetchCompletion) -> AnyCancellable? {
        let args = ["apikey": .apiKey,
                    "type": "movie",
                    "s": searchedPhrase,
                    "page": String(page)]
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: args))
        return networkingService.request(with: endpointDefiniton, completion: completion)
    }
}
