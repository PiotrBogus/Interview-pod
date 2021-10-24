
import XCTest

public extension XCUIElementQuery {

    var lastMatch: XCUIElement { element(boundBy: count - 1) }
    
    func filter(using predicates: Predicate...) -> XCUIElementQuery {
        filter(using: predicates)
    }

    func filter(using predicates: [Predicate]) -> XCUIElementQuery {
        containing(predicates.predicate)
    }
    
    func contains(_ predicates: Predicate...) -> Bool {
        filter(using: predicates).count != 0
    }
}

