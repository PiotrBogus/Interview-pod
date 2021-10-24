
import Shared
import XCTest

public extension XCUIElement {

    var centerCoordinate: XCUICoordinate {
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    }

    func forceTap() {
        centerCoordinate.tap()
    }

    func scrollTo(element: XCUIElement) {
        if frame.minY > element.frame.minY {
            scrollUpTo(element: element)
        } else {
            scrollDownTo(element: element)
        }
    }

    func scrollDownTo(element: XCUIElement) {
        while frame.contains(element.frame) == false {
            centerCoordinate.press(forDuration: 0.05, thenDragTo: centerCoordinate.withOffset(CGVector(dx: 0, dy: -element.frame.height / 2)))
        }
    }

    func scrollUpTo(element: XCUIElement) {
        while frame.contains(element.frame) == false {
            centerCoordinate.press(forDuration: 0.05, thenDragTo: centerCoordinate.withOffset(CGVector(dx: 0, dy: element.frame.height / 2)))
        }
    }
}
