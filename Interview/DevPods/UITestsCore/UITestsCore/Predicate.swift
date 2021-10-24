
import Foundation
import XCTest

public enum Predicate {
    case valueEqualsTo(String)
    case labelEqualsTo(String), labelBeginsWith(String), labelContains(String, isCaseSensitive: Bool = false)
    case identifierContains(String), identifierBeginsWith(String)
    case exists, notExists
    case isHittable, isNotHittable
    case isEnabled, isNotEnabled
    case isSelected
    case count(Int)
    case isSwitchOn, isSwitchOff
    indirect case negation(of: Predicate)

    public var format: String {
        switch self {
        case let .valueEqualsTo(value):
            return "value == '\(value)'"
        case let .labelEqualsTo(label):
            return "label == '\(label)'"
        case let .labelBeginsWith(label):
            return "label BEGINSWITH '\(label)'"
        case let .labelContains(label, isCaseSensitive):
            return "label CONTAINS\(isCaseSensitive ? "" : "[c]") '\(label)'"
        case let .identifierContains(id):
            return "identifier CONTAINS[c] '\(id)'"
        case let .identifierBeginsWith(prefix):
            return "identifier BEGINSWITH '\(prefix)'"
        case .exists:
            return "exists == true"
        case .notExists:
            return "exists == false"
        case .isHittable:
            return "hittable == true"
        case .isNotHittable:
            return "hittable == false"
        case .isEnabled:
            return "enabled == true"
        case .isNotEnabled:
            return "enabled == false"
        case .isSelected:
            return "isSelected == true"
        case let .count(number):
            return "count == \(number)"
        case let .negation(predicate):
            return "NOT (\(predicate.format))"
        case .isSwitchOn:
            return "value == '1'"
        case .isSwitchOff:
            return "value == '0'"
        }
    }

    public var predicate: NSPredicate { NSPredicate(format: format) }
}

public extension Array where Element == Predicate {

    var predicate: NSPredicate { NSPredicate(format: map(\.format).joined(separator: " AND ")) }
}

public extension XCUIElementQuery {

    func matching(_ predicate: Predicate) -> XCUIElementQuery {
        matching(predicate.predicate)
    }
}
