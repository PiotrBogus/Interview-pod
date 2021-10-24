
import Shared
import XCTest
@testable import MovieList

final class MovieListPresenterTests: XCTestCase {
        
    func testLoadMovieListWithSuccessResponse() {
        let interactor = MovieListInteractorMock(okResponse: true)
        let interactorDelegate = MovieListInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieListPresenter(interactor: interactor, router: MovieListRouterMock())
        presenter.loadMovieList(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetch)
    }
    
    func testLoadMovieListWithFailedResponse() {
        let interactor = MovieListInteractorMock()
        let interactorDelegate = MovieListInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieListPresenter(interactor: interactor, router: MovieListRouterMock())
        presenter.loadMovieList(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetchMovieList)
    }
    
    func testLoadMoreMoviestWithSuccessResponse() {
        let interactor = MovieListInteractorMock(okResponse: true)
        let interactorDelegate = MovieListInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieListPresenter(interactor: interactor, router: MovieListRouterMock())
        presenter.loadMoreMovies(for: "marvel", page: 2)
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetchMore)
    }
    
    func testLoadMoreMoviestWithFailedResponse() {
        let interactor = MovieListInteractorMock(okResponse: false)
        let interactorDelegate = MovieListInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieListPresenter(interactor: interactor, router: MovieListRouterMock())
        presenter.loadMoreMovies(for: "marvel", page: 2)
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetchMoreMovie)
    }
    
    func testShowDetails() {
        let router = MovieListRouterMock()
        
        let presenter = MovieListPresenter(interactor: MovieListInteractorMock(), router: router)
        presenter.showDetails(for: Movie.fixture, on: UIViewController())
        
        XCTAssertTrue(router.didCallShowMovieDetails)
    }
}
