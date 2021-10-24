
import Foundation

public protocol ElementValidator {

    associatedtype Object: NSObject

    init()
    func verify(_ object: Object, using predicates: [Predicate], timeout: TimeInterval, file: StaticString, line: UInt)
    func validate(_ object: Object, using predicates: [Predicate], timeout: TimeInterval) -> Bool
}

public typealias AnyObjectElementValidator = AnyElementValidator<NSObject>

public struct AnyElementValidator<Object: NSObject>: ElementValidator {

    public typealias VerifyHandler = (_ object: Object, _ predicates: [Predicate], _ timeout: TimeInterval, _ file: StaticString, _ line: UInt) -> Void
    public typealias ValidateHandler = (_ object: Object, _ predicates: [Predicate], _ timeout: TimeInterval) -> Bool

    public func verify(_ object: Object, using predicates: [Predicate], timeout: TimeInterval, file: StaticString, line: UInt) {
        verifyHandler(object, predicates, timeout, file, line)
    }

    public func validate(_ object: Object, using predicates: [Predicate], timeout: TimeInterval) -> Bool {
        validateHandler(object, predicates, timeout)
    }

    private let verifyHandler: VerifyHandler
    private let validateHandler: ValidateHandler

    public init() {
        fatalError()
    }

    public init<EV: ElementValidator>(validator: EV) where EV.Object == Object {
        verifyHandler = validator.verify(_:using:timeout:file:line:)
        validateHandler = validator.validate(_:using:timeout:)
    }
}
