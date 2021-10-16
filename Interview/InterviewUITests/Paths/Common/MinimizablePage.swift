
import XCTest
import UITestsCore

protocol MinimizablePage: Page {
    var test: XCTestCase { get }
}

extension MinimizablePage {

    @discardableResult
    func pressHome() -> Self {
        device.press(.home)

        return self
    }

    @discardableResult
    func activate() -> Self {
        app.activate()

        return self
    }

    @discardableResult
    func wait(timeout: TimeInterval = .timeout) -> Self {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        test.wait(for: [delayExpectation], timeout: timeout)

        return self
    }

}
