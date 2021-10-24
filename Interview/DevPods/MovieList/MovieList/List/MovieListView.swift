
import Foundation
import Utils
import UIKit
import Shared

protocol MovieListViewDelegate: AnyObject {
    func didSelect(movie: Movie)
    func didSearch(for searchedPhrase: String)
    func didLoadMore()
}

final class MovieListView: BaseView {
    
    private enum Constants {
        static let numberOfItemsAtPage: Int = 10
    }
    
    weak var delegate: MovieListViewDelegate?
            
    private let searchBar = BaseSearchBar()
    private let emptyView = MovieListEmptyView()
    private let collectionView = UICollectionView(frame: .componentBounds, collectionViewLayout: CollectionViewColumnBuilder().buildLayout())
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private lazy var movieListDataSource: MovieListDataSource = MovieListDataSourceBuilder().build(collectionView: collectionView)
    
    func emptyView(isHidden: Bool) {
        isHidden ? hideEmptyView() : showEmptyView()
    }
    
    func set(movies: [Movie]) {
        hideActivityIndicator()
        movieListDataSource.refresh(for: movies)
    }
    
    func append(movies: [Movie]) {
        movieListDataSource.append(movies: movies)
    }
    
    override func setUpSubviews() {
        elementIdentifier = ElementIdentifiers.MovieList.view
        backgroundColor = .introBackgroundColor
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .whiteColor
        setUpSearchBar()
        setUpCollectionView()
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
            searchBar,
            collectionView,
            activityIndicatorView
        ])
    }
    
    override func setUpConstraints() {
        setUpSearchBarConstraints()
        setUpCollectionViewConstraints()
        setUpActivityindicatorViewConstraints()
    }
    
    private func setUpSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setUpCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpActivityindicatorViewConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.dataSource = movieListDataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .introBackgroundColor
    }
    
    private func setUpSearchBar() {
        searchBar.tintColor = .whiteColor
        searchBar.barTintColor = .introBackgroundColor
        searchBar.backgroundColor = .introBackgroundColor
        searchBar.searchTextField.textColor = .whiteColor
        searchBar.searchTextField.tintColor = .whiteColor
        searchBar.searchTextField.backgroundColor = .systemGray3Color
        searchBar.placeholder = "movie_list_screen_search_bar_placeholder".localized
        searchBar.delegate = self
        searchBar.elementIdentifier = ElementIdentifiers.MovieList.searchBar
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    private func showEmptyView() {
        addSubview(emptyView)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func hideEmptyView() {
        emptyView.removeFromSuperview()
    }
}

extension MovieListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieListDataSource.getMovie(for: indexPath.row)
        delegate?.didSelect(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row % Constants.numberOfItemsAtPage == 0 else { return }
        
        delegate?.didLoadMore()
    }
}

extension MovieListView: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        startSearch(for: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
    }
    
    private func startSearch(for text: String?) {
        guard let text = text,
              text.isEmpty == false else { return }
        
        emptyView(isHidden: true)
        set(movies: [])
        showActivityIndicator()
        delegate?.didSearch(for: text)
    }
}
