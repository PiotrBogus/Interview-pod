
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
        let publisher = detailsFetcher.fetchDetails(for: id) { [weak self] result in
            guard let movie = try? result.get() else {
                self?.delegate?.didFailFetch()
                return
            }
            
            self?.delegate?.didFetch(movie: movie)
        }
        
        publisher?.store(in: &cancelables)
    }
}
