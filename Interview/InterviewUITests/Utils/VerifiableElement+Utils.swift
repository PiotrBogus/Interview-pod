
import XCTest
import UITestsCore

extension VerifiableElement {

    public var validator: Validator { .init() }
}

extension XCUIElement: VerifiableElement {

    public typealias Validator = DefaultElementValidator<XCUIElement>
    
    @discardableResult
    func verify(_ predicates: Predicate...,
                timeout: TimeInterval = .timeout,
                file: StaticString,
                line: UInt) -> Self {
        verify(predicates, timeout: timeout, file: file, line: line)
    }

    @discardableResult
    func verify(_ predicates: [Predicate],
                timeout: TimeInterval = .timeout,
                file: StaticString,
                line: UInt) -> Self {
        validator.verify(self, using: predicates, timeout: timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func validate(_ predicates: Predicate..., timeout: TimeInterval = .timeout) -> Bool {
        validate(predicates, timeout: timeout)
    }

    @discardableResult
    func validate(_ predicates: [Predicate], timeout: TimeInterval = .timeout) -> Bool {
        validator.validate(self, using: predicates, timeout: timeout)
    }
}

extension XCUIElementQuery: VerifiableElement {

    public typealias Validator = DefaultElementValidator<XCUIElementQuery>

    @discardableResult
    func verify(_ predicates: Predicate...,
                timeout: TimeInterval = .timeout,
                file: StaticString,
                line: UInt) -> Self {
        verify(predicates, timeout: timeout, file: file, line: line)
    }

    @discardableResult
    func verify(_ predicates: [Predicate],
                timeout: TimeInterval = .timeout,
                file: StaticString,
                line: UInt) -> Self {
        validator.verify(self, using: predicates, timeout: timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func validate(_ predicates: Predicate..., timeout: TimeInterval = .timeout) -> Bool {
        validate(predicates, timeout: timeout)
    }

    @discardableResult
    func validate(_ predicates: [Predicate], timeout: TimeInterval = .timeout) -> Bool {
        validator.validate(self, using: predicates, timeout: timeout)
    }

    @discardableResult
    func contains(_ predicates: Predicate..., file: StaticString, line: UInt) -> Self {
        validator.contains(self, predicates: predicates, file: file, line: line)

        return self
    }

    @discardableResult
    func verifyElementCount(using predicates: [Predicate], count: Int, file: StaticString, line: UInt) -> Self {
        validator.verifyElementCount(self, using: predicates, count: count, file: file, line: line)

        return self
    }
}
