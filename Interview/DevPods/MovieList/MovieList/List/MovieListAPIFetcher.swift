
import Shared
import Combine

public typealias MovieListFetchCompletion = (Result<MovieList?, NetworkingError>) -> Void

public protocol MovieListAPIFetcher {
    func fetchList(for searchedPhrase: String, page: Int, completion: @escaping MovieListFetchCompletion) -> AnyCancellable?
}
