//
//import XCTest
//
//extension BaseScreen {
//
//    func waitForElementAndTap(element: XCUIElement, timeout: TimeInterval = 30.0) {
//        if element.waitForExistence(timeout: timeout), element.isHittable {
//            element.tap()
//        }
//    }
//
//    func waitForElementAndForceTap(element: XCUIElement, timeout: TimeInterval = 30.0) {
//        if element.waitForExistence(timeout: timeout), element.isHittable {
//            element.forceTap()
//        }
//    }
//
//    func waitToExist(for element: XCUIElement, waiting timeout: TimeInterval = 10.0) {
//        let exists = NSPredicate(format: "exists == true")
//
//        testCase.expectation(for: exists, evaluatedWith: element, handler: nil)
//        testCase.waitForExpectations(timeout: timeout, handler: nil)
//    }
//
//    func waitToDisappear(for element: XCUIElement, waiting timeout: TimeInterval = 10.0) {
//        let notExists = NSPredicate(format: "exists == false")
//
//        testCase.expectation(for: notExists, evaluatedWith: element, handler: nil)
//        testCase.waitForExpectations(timeout: timeout, handler: nil)
//    }
//
//    func waitToBeHittable(for element: XCUIElement, waiting timeout: TimeInterval = 10.0) {
//        waitToExist(for: element, waiting: timeout)
//
//        let exists = NSPredicate(format: "hittable == true")
//        testCase.expectation(for: exists, evaluatedWith: element, handler: nil)
//        testCase.waitForExpectations(timeout: timeout, handler: nil)
//    }
//}
