
@testable import PageLinks
import XCTest

class PagesLinksGeneralTests: XCTestCase {

    let provider = PagesLinksProvider(linksSet: GenericPagesLinksSet())

    func testPrivacyPolicyLinks() {
        XCTAssertNotNil(provider.getPrivacyPolicyLink())
    }

    func testTermsOfUseLinks() {
        XCTAssertNotNil(provider.getTermsOfUseLink())
    }

    private class GenericPagesLinksSet: PagesLinksSet {

        let termsOfUseLinks = "https://google.com"

        let privacyPolicyLinks = "https://google.com"
    }
}
