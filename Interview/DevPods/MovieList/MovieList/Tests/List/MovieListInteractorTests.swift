
import Shared
import XCTest
@testable import MovieList

final class MovieListInteractorTests: XCTestCase {
        
    func testFetchMovieListWithOKResponse() {
        let apiListFetcher = MovieListAPIFetcherMock(okResponse: true)
        let interactorDelegate = MovieListInteractorDelegateMock()

        let interactor = MovieListInteractor(apiListFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchMovieList(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetch)
    }
    
    func testFetchMovieListWithErrorResponse() {
        let apiListFetcher = MovieListAPIFetcherMock()
        let interactorDelegate = MovieListInteractorDelegateMock()

        let interactor = MovieListInteractor(apiListFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchMovieList(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetchMovieList)
    }
    
    func testFetchMoreMoviestWithOKResponse() {
        let apiListFetcher = MovieListAPIFetcherMock(okResponse: true)
        let interactorDelegate = MovieListInteractorDelegateMock()

        let interactor = MovieListInteractor(apiListFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchMoreMovies(for: "marvel", page: 2)
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetchMore)
    }
    
    func testFetchMoreMoviestWithErrorResponse() {
        let apiListFetcher = MovieListAPIFetcherMock(okResponse: false)
        let interactorDelegate = MovieListInteractorDelegateMock()

        let interactor = MovieListInteractor(apiListFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchMoreMovies(for: "marvel", page: 2)
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetchMoreMovie)
    }
}
