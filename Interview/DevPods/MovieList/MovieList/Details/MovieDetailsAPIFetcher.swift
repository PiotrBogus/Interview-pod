
import Foundation
import Shared
import Combine
import Networking

public protocol MovieDetailsAPIFetcher {
    func fetchDetails(for id: String) -> AnyPublisher<Movie, NetworkRequestError>
}
