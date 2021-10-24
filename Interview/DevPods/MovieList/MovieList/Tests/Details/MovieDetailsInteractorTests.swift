
import Shared
import XCTest
@testable import MovieList

final class MovieDetailsInteractorTests: XCTestCase {
        
    func testFetchMovieDetailsWithOKResponse() {
        let apiListFetcher = MovieDetailsAPIFetcherMock(okResponse: true)
        let interactorDelegate = MovieDetailsInteractorDelegateMock()

        let interactor = MovieDetailsInteractor(detailsFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchDetails(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetch)
    }
    
    func testFetchMovieDetailsWithErrorResponse() {
        let apiListFetcher = MovieDetailsAPIFetcherMock()
        let interactorDelegate = MovieDetailsInteractorDelegateMock()

        let interactor = MovieDetailsInteractor(detailsFetcher: apiListFetcher)
        interactor.delegate = interactorDelegate
        interactor.fetchDetails(for: "marvel")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetch)
    }
}
