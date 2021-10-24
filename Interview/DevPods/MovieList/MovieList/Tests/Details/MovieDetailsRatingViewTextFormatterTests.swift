
import Utils
import XCTest
@testable import MovieList

final class MovieDetailsRatingViewTextFormatterTests: XCTestCase {
        
    func testPrepareTextWithTitle() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepareText(with: .checkmark, text: "test_text")
                
        XCTAssertNotNil(result)
    }
    
    func testPrepareTextWithEmptyTitle() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepareText(with: .checkmark, text: nil)
                
        XCTAssertNil(result)
    }
    
    func testPreparePlotTextWithPlot() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.preparePlotText(plot: "test_plot")
                
        XCTAssertNotNil(result)
    }
    
    func testPreparePlotTextWithEmptyPlot() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.preparePlotText(plot: nil)
                
        XCTAssertNil(result)
    }
    
    func testPrepare2LinesTextWithTitleAndDescription() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepare2LinesText(with: "test_title", description: "test_description")
                
        let expectedResult = "test_title\ntest_description"
        XCTAssertEqual(result!.string, expectedResult)
    }
    
    func testPrepare2LinesTextWithEmptyTitleAndDescription() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepare2LinesText(with: nil, description: "test_description")
                
        XCTAssertNil(result)
    }
    
    func testPrepare2LinesTextWithTitleAndEmptyDescription() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepare2LinesText(with: "test_title", description: nil)
        
        XCTAssertNil(result)
    }
    
    func testPrepare2LinesTextWithEmptyTitleAndEmptyDescription() {
        let textFormatter = MovieDetailsRatingViewTextFormatter()
        let result = textFormatter.prepare2LinesText(with: nil, description: nil)
        
        XCTAssertNil(result)
    }
}
