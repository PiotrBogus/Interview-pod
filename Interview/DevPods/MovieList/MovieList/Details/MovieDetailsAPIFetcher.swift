
import Foundation
import Shared

public typealias MovieDetailsFetchCompletion = (Result<Movie?, NetworkingError>) -> Void

public protocol MovieDetailsAPIFetcher {
    func fetchDetails(for id: String, completion: @escaping MovieDetailsFetchCompletion)
}
