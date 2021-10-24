
import Foundation
import Shared

protocol MovieDetailsPresenterDelegate: AnyObject {
    func didFetch(movie: Movie)
    func didFailFetch()
}

protocol MovieDetailsPresenterInterface {
    var delegate: MovieDetailsPresenterDelegate? { get set }
    
    func fetchDetails(for id: String)
}

final class MovieDetailsPresenter: MovieDetailsPresenterInterface {
    
    weak var delegate: MovieDetailsPresenterDelegate?
    
    private let interactor: MovieDetailsInteractorInterface
    
    init(interactor: MovieDetailsInteractorInterface) {
        self.interactor = interactor
    }
    
    func fetchDetails(for id: String) {
        interactor.fetchDetails(for: id)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorDelegate {
    
    func didFetch(movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didFetch(movie: movie)
        }
    }
    
    func didFailFetch() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didFailFetch()
        }
    }
}
