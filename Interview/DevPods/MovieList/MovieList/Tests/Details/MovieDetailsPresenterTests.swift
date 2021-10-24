
import Shared
import XCTest
@testable import MovieList

final class MovieDetailsPresenterTests: XCTestCase {
        
    func tesFetchMovieDetailsWithSuccessResponse() {
        let interactor = MovieDetailsInteractorMock(okResponse: true)
        let interactorDelegate = MovieDetailsInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieDetailsPresenter(interactor: interactor)
        presenter.fetchDetails(for: "test_id")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFetch)
    }
    
    func tesFetchMovieDetailsWithFailedResponse() {
        let interactor = MovieDetailsInteractorMock(okResponse: false)
        let interactorDelegate = MovieDetailsInteractorDelegateMock()
        interactor.delegate = interactorDelegate
        
        let presenter = MovieDetailsPresenter(interactor: interactor)
        presenter.fetchDetails(for: "test_id")
        
        XCTAssertTrue(interactorDelegate.didCall_DidFailFetch)
    }
}
