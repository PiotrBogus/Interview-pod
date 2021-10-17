
import XCTest

protocol Paths: AnyObject {
    associatedtype StepsType: Steps

    var steps: StepsType { get }
    var factory: StepsFactory { get }
}