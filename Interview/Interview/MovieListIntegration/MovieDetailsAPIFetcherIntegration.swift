
import Foundation
import Shared
import Networking
import MovieList

final class MovieDetailsAPIFetcherIntegration: MovieDetailsAPIFetcher {
    
    private let endpoint = "/"
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = DefaultNetworkingService(baseURL: .baseURL)) {
        self.networkingService = networkingService
    }
    
    func fetchDetails(for id: String, completion: @escaping MovieDetailsFetchCompletion) {
        let args = ["apikey": .apiKey,
                    "i": id]
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: args))
        networkingService.request(with: endpointDefiniton, completion: completion)
    }    
}
