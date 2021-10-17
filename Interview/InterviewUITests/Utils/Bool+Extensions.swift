
import Foundation
import UITestsCore

extension Bool {

    var existencePredicate: Predicate {
        self ? .exists : .notExists
    }
}
