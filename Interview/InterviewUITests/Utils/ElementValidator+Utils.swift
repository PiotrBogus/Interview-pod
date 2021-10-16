
import XCTest
import UITestsCore

public struct DefaultElementValidator<Element: NSObject>: ElementValidator {

    public typealias Object = Element

    public init() {}
}

extension ElementValidator {

    public func verify(_ object: Object, using predicates: [Predicate], timeout: TimeInterval = .timeout, file: StaticString, line: UInt) {
        if validate(object, using: predicates, timeout: timeout) == false {
            XCTFail("[\(self)] Element \(object.description) did not fulfill expectation: \(predicates.map(\.format))",
                    file: file,
                    line: line)
        }
    }

    public func validate(_ object: Object, using predicates: [Predicate], timeout: TimeInterval) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: predicates.predicate, object: object)

        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }
}

extension ElementValidator where Object == XCUIElementQuery {

    func contains(_ element: Object, predicates: [Predicate], file: StaticString, line: UInt) {
        if element.filter(using: predicates).count == 0 {
            XCTFail("[\(self)] Element \(element.description) does not contain descendants using: \(predicates.map(\.format)) predicate",
                    file: file,
                    line: line)
        }
    }
    
    func verifyElementCount(_ element: Object, using predicates: [Predicate], count: Int, file: StaticString, line: UInt) {
        let query = element.matching(predicates.predicate)

        XCTAssertEqual(query.count, count, "[\(self)] Number of elements for \(query.description) is not equal to \(count)", file: file, line: line)
    }
}
