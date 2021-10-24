
import Foundation
import UIKit
import Shared

final class MovieDetailsBuilder {
    
    func build(detailsFetcher: MovieDetailsAPIFetcher, movie: Movie) -> UIViewController {
        let interactor = MovieDetailsInteractor(detailsFetcher: detailsFetcher)
        let presenter = MovieDetailsPresenter(interactor: interactor)
        let viewController = MovieDetailsViewController(presenter: presenter, movie: movie)
        
        interactor.delegate = presenter
        presenter.delegate = viewController
        
        return viewController
    }
}
