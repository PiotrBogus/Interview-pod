
import Shared
import XCTest

public extension XCUIElement {

    subscript(element id: UIElementIdentifier) -> XCUIElement {
        descendants(matching: id.type.xcElementType)[id.id].firstMatch
    }
    
    subscript(query id: UIElementIdentifier) -> XCUIElementQuery {
        self[query: id, partial: false]
    }

    subscript(query id: UIElementIdentifier, partial partial: Bool) -> XCUIElementQuery {
        let query = descendants(matching: id.type.xcElementType)
            
        return partial ? query.filter(using: .identifierContains(id.id)) : query.matching(identifier: id.id)
    }
}

public extension XCUIElementQuery {

    subscript(element id: UIElementIdentifier) -> XCUIElement {
        descendants(matching: id.type.xcElementType)[id.id].firstMatch
    }
    
    subscript(query id: UIElementIdentifier) -> XCUIElementQuery {
        self[query: id, partial: false]
    }

    subscript(query id: UIElementIdentifier, partial partial: Bool) -> XCUIElementQuery {
        let query = descendants(matching: id.type.xcElementType)
            
        return partial ? query.filter(using: .identifierContains(id.id)) : query.matching(identifier: id.id)
    }
}

public extension ElementType {

    var xcElementType: XCUIElement.ElementType { XCUIElement.ElementType(rawValue: rawValue)! }
}
