
import Shared
import XCTest
@testable import MovieList

final class MovieDetailsAdditionalnformationTextFormatterTests: XCTestCase {
        
    func testTextFormatWithTitleAndDescriiption() {
        let textFormatter = MovieDetailsAdditionalnformationTextFormatter()
        let result = textFormatter.prepareText(title: "test_title", description: "test_description")
        
        let expectedResult = "test_title: test_description"
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.string, expectedResult)
    }
    
    func testTextFormatWithEmptyTitleAndEmptyDescription() {
        let textFormatter = MovieDetailsAdditionalnformationTextFormatter()
        let result = textFormatter.prepareText(title: nil, description: nil)
        
        XCTAssertNil(result)
    }
    
    func testTextFormatWithEmptyTitleAndDescription() {
        let textFormatter = MovieDetailsAdditionalnformationTextFormatter()
        let result = textFormatter.prepareText(title: nil, description: "test_description")
        
        XCTAssertNil(result)
    }
    
    func testTextFormatWithTitleAndEmptyDescription() {
        let textFormatter = MovieDetailsAdditionalnformationTextFormatter()
        let result = textFormatter.prepareText(title: "test_title", description: nil)
        
        XCTAssertNil(result)
    }
}
