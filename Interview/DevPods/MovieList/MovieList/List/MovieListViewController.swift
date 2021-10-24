
import Utils
import UIKit
import Shared

final class MovieListViewController: BaseViewController {
    
    private let presenter: MovieListPresenterInterface
    private let castedView = MovieListView()
    
    private var searchedPhrase: String = ""
    private var movieList: MovieList?
    
    init(presenter: MovieListPresenterInterface) {
        self.presenter = presenter
        
        super.init()
    }
    
    override func loadView() {
        view = castedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "movie_list_screen_title".localized
        castedView.delegate = self
    }
}

extension MovieListViewController: MovieListPresenterDelegate {
    
    func didLoad(movieList: MovieList) {
        self.movieList = movieList
        castedView.set(movies: movieList.movies)
    }
    
    func didLoadMore(movies: [Movie]) {
        movieList?.movies.append(contentsOf: movies)
        castedView.append(movies: movies)
    }
        
    func didFailFetchMovieList() {
        castedView.set(movies: [])
        castedView.emptyView(isHidden: false)
    }
}

extension MovieListViewController: MovieListViewDelegate {
    
    func didLoadMore() {
        guard let movieList = movieList,
              movieList.movies.count < Int(movieList.totalResults) ?? 0 else { return }

        let page = movieList.movies.count / 10 + 1
        presenter.loadMoreMovies(for: searchedPhrase, page: page)
    }
    
    func didSelect(movie: Movie) {
        presenter.showDetails(for: movie, on: self)
    }
    
    func didSearch(for searchedPhrase: String) {
        self.searchedPhrase = searchedPhrase
        presenter.loadMovieList(for: searchedPhrase)
    }
}
