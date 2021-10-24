
import Foundation
import Shared
import Networking
import MovieList
import Combine

final class MovieDetailsAPIFetcherIntegration: MovieDetailsAPIFetcher {
    
    private let endpoint = "/"
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = DefaultNetworkingService(baseURL: .baseURL)) {
        self.networkingService = networkingService
    }
    
    func fetchDetails(for id: String, completion: @escaping MovieDetailsFetchCompletion) -> AnyCancellable? {
        let args = ["apikey": .apiKey,
                    "i": id]
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: args))
        return networkingService.request(with: endpointDefiniton, completion: completion)
    }    
}
