
import XCTest

extension XCUIElement {

    func forceTap() {
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
    }

    func clearText() {
        guard let stringValue = value as? String else {
            print("Tried to clear and enter text into a non string value")

            return
        }

        let deleteString = stringValue.map { _ in "\u{8}" }.joined(separator: "")

        typeText(deleteString)
    }

    func dragDown() {
        centerCoordinate.press(forDuration: 0.05, thenDragTo: centerCoordinate.withOffset(CGVector(dx: 0, dy: UIScreen.main.bounds.height)))
    }

    var trimmedLabel: String {
        label.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    var centerCoordinate: XCUICoordinate {
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    }

    func isSwitchOn() -> Bool {
        guard elementType == .switch else {
            return false
        }

        return value as? String == "1"
    }
}
