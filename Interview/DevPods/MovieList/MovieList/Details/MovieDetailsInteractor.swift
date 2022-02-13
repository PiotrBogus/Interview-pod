
import Foundation
import Shared
import Combine

protocol MovieDetailsInteractorDelegate: AnyObject {
    func didFetch(movie: Movie)
    func didFailFetch()
}

protocol MovieDetailsInteractorInterface {
    var delegate: MovieDetailsInteractorDelegate? { get set }
    
    func fetchDetails(for id: String)
}

final class MovieDetailsInteractor: MovieDetailsInteractorInterface {
            
    weak var delegate: MovieDetailsInteractorDelegate?
    
    private let detailsFetcher: MovieDetailsAPIFetcher
    private var cancelables: [AnyCancellable] = []
    
    init(detailsFetcher: MovieDetailsAPIFetcher) {
        self.detailsFetcher = detailsFetcher
    }
    
    func fetchDetails(for id: String) {
        detailsFetcher.fetchDetails(for: id)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movie in
                    self?.delegate?.didFetch(movie: movie)
            }).store(in: &cancelables)
    }
}
