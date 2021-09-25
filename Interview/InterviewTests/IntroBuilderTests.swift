
import XCTest
@testable import Interview

final class IntroBuilderTests: XCTestCase {

    func testBuild() {
        let vc = IntroBuilder().build()
        XCTAssertNotNil(vc)
    }
}
