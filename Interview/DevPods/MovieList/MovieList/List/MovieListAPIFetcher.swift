
import Shared
import Combine
import Networking

public protocol MovieListAPIFetcher {
    func fetchList(for searchedPhrase: String, page: Int) -> AnyPublisher<MovieList, NetworkRequestError>
}
