
import XCTest
@testable import MovieList

final class MovieDetailsBuilderTests: XCTestCase {

    func testBuild() {
        let vc = MovieDetailsBuilder().build(detailsFetcher: MovieDetailsAPIFetcherMock(),
                                             movie: .fixture)
        XCTAssertNotNil(vc)
    }
}
