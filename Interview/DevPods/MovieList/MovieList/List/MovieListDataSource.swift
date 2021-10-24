
import Shared
import UIKit

enum MovieListSection: Int, CaseIterable {
    case main
}

typealias MovieListSnapshotDataSource = NSDiffableDataSourceSnapshot<MovieListSection, Movie>
typealias MovieListCellRegistration = UICollectionView.CellRegistration<MovieCell, Movie>

final class MovieListDataSource: UICollectionViewDiffableDataSource<MovieListSection, Movie> {
    
    private var movies: [Movie] = []
    
    private var snapshotDataSource: MovieListSnapshotDataSource {
        var snapshot = MovieListSnapshotDataSource()
        snapshot.appendSections(MovieListSection.allCases)
        snapshot.appendItems(movies, toSection: MovieListSection.main)
        return snapshot
    }
    
    func append(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        var snapshot = self.snapshot()
        snapshot.appendItems(movies, toSection: .main)
        apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func refresh(for movies: [Movie]) {
        self.movies = movies
        apply(snapshotDataSource)
    }
    
    func getMovie(for index: Int) -> Movie {
        movies[index]
    }
}

final class MovieListDataSourceBuilder {
    
    var movies: [Movie] = []
    
    func build(collectionView: UICollectionView) -> MovieListDataSource {
        return MovieListDataSource(collectionView: collectionView,
                                   cellProvider: makeCellRegistration().cellProvider)
    }
    
    private func makeCellRegistration() -> MovieListCellRegistration {
        MovieListCellRegistration { cell, indexPath, movie in
            cell.configure(with: movie)
        }
    }
}

private extension UICollectionView.CellRegistration {
    
    var cellProvider: (UICollectionView, IndexPath, Item) -> MovieCell {
        return { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: self,
                for: indexPath,
                item: item
            ) as! MovieCell
        }
    }
}
