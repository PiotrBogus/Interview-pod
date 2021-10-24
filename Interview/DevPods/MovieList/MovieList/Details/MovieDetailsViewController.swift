
import Utils
import UIKit
import Shared

final class MovieDetailsViewController: BaseViewController {
    
    private let presenter: MovieDetailsPresenterInterface
    private var movie: Movie
    private lazy var castedView = MovieDetailsView(movie: movie)
    
    init(presenter: MovieDetailsPresenterInterface, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
        
        super.init()
    }
    
    override func loadView() {
        view = castedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "movie_details_screen_title".localized
        castedView.delegate = self
        castedView.loader(isHidden: false)
        presenter.fetchDetails(for: movie.imdbID)
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterDelegate {
    
    func didFetch(movie: Movie) {
        self.movie = movie
        castedView.loader(isHidden: true)
        castedView.fill(with: movie)
    }
    
    func didFailFetch() {
        castedView.loader(isHidden: true)
        castedView.retryView(isHidden: false)
    }
}

extension MovieDetailsViewController: MovieDetailsViewDelegate {
    
    func didTapRetryButton() {
        castedView.retryView(isHidden: true)
        castedView.loader(isHidden: false)
        presenter.fetchDetails(for: movie.imdbID)
    }
}
