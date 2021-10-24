
import Foundation
import Shared

protocol MovieDetailsInteractorDelegate: AnyObject {
    func didFetch(movie: Movie)
    func didFailFetch()
}

protocol MovieDetailsInteractorInterface {
    var delegate: MovieDetailsInteractorDelegate? { get set }
    
    func fetchDetails(for id: String)
}

final class MovieDetailsInteractor: MovieDetailsInteractorInterface {
        
    private let detailsFetcher: MovieDetailsAPIFetcher
    
    weak var delegate: MovieDetailsInteractorDelegate?
    
    init(detailsFetcher: MovieDetailsAPIFetcher) {
        self.detailsFetcher = detailsFetcher
    }
    
    func fetchDetails(for id: String) {
        detailsFetcher.fetchDetails(for: id) { [weak self] result in
            guard let movie = try? result.get() else {
                self?.delegate?.didFailFetch()
                return
            }
            
            self?.delegate?.didFetch(movie: movie)
        }
    }
}
