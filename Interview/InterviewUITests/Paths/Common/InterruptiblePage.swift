
import XCTest

protocol InterruptiblePage: Page {
    var test: XCTestCase { get }
}

extension InterruptiblePage {

    @discardableResult
    func monitorInterruption(handler: @escaping (XCUIElement) -> Bool) -> NSObjectProtocol {
        test.addUIInterruptionMonitor(withDescription: #file, handler: handler)
    }
}
