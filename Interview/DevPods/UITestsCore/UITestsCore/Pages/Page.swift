
import XCTest

public protocol Page: AnyObject {

    var id: String { get }
    var type: XCUIElement.ElementType { get }
    var app: XCUIApplication { get }
    var test: XCTestCase { get }
    var device: XCUIDevice { get }

    var backButton: XCUIElement { get }
    var validator: AnyObjectElementValidator { get }
}

public extension Page {

    var type: XCUIElement.ElementType { .any }
    var screen: XCUIElement {
        let elements = app.descendants(matching: type)

        return id.isEmpty ? elements.firstMatch : elements[id].firstMatch
    }

    var exists: Bool { screen.exists }
    var keyboard: KeyboardPage { KeyboardPage(app: app, validator: validator) }
    var test: XCTestCase { fatalError(#function) }
    var navigationBar: XCUIElement { app.navigationBars.lastMatch }
    var backButton: XCUIElement { navigationBar.buttons.firstMatch }
    var device: XCUIDevice { .shared }
}

// MARK: Tapping actions

public extension Page {

    @discardableResult
    func tap(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath]
            .tap()

        return self
    }

    @discardableResult
    func forceTap(_ keyPath: KeyPath<Self, XCUIElement>) -> Self {
        self[keyPath: keyPath]
            .forceTap()

        return self
    }

    @discardableResult
    func tapQueryElement(_ keyPath: KeyPath<Self, XCUIElementQuery>, identifier: String) -> Self {
        elementQuery(keyPath, identifier: identifier).tap()

        return self
    }

    @discardableResult
    func tapQueryElement(_ keyPath: KeyPath<Self, XCUIElementQuery>, atIndex index: Int) -> Self {
        elementQuery(keyPath, atIndex: index).tap()

        return self
    }

    @discardableResult
    func tapQueryElement(_ keyPath: KeyPath<Self, XCUIElementQuery>, matching predicate: Predicate) -> Self {
        elementQuery(keyPath, predicate: predicate)
            .tap()

        return self
    }

    @discardableResult
    func tapQueryElementDescendants(_ keyPath: KeyPath<Self, XCUIElementQuery>, identifier: String, type: XCUIElement.ElementType = .any) -> Self {
        elementQueryDescendants(keyPath, identifier: identifier, type: type)
            .tap()

        return self
    }

    @discardableResult
    func pickElement(_ keyPath: KeyPath<Self, XCUIElement>, atIndex index: Int, with value: String) -> Self {
        self[keyPath: keyPath]
            .pickerWheels.element(boundBy: index).adjust(toPickerWheelValue: value)

        return self
    }

    @discardableResult
    func tapBackButton() -> Self {
        backButton
            .tap()

        return self
    }
}

// MARK: Typing actions

public extension Page {

    @discardableResult
    func type(text: String, forTextField keyPath: KeyPath<Self, TextFieldPage>, file: StaticString, line: UInt) -> TextFieldPage {
        self[keyPath: keyPath]
            .type(value: text, file: file, line: line)
    }

    @discardableResult
    func typeAndReturn(text: String, forTextField keyPath: KeyPath<Self, TextFieldPage>, file: StaticString, line: UInt) -> Self {
        let textField = type(text: text, forTextField: keyPath, file: file, line: line)
        textField.keyboard.tapReturn()

        return self
    }

    @discardableResult
    func clearText(forTextField keyPath: KeyPath<Self, TextFieldPage>, file: StaticString, line: UInt) -> TextFieldPage {
        self[keyPath: keyPath]
            .clear(file: file, line: line)
    }

    @discardableResult
    func type(text: String, file: StaticString, line: UInt) -> Self {
        keyboard
            .waitForAppearance(file: file, line: line)
            .type(value: text, file: file, line: line)

        return self
    }

    @discardableResult
    func tapKeyboardReturn(file: StaticString, line: UInt) -> Self {
        keyboard
            .waitForAppearance(file: file, line: line)
            .tapReturn()

        return self
    }
}

// MARK: Scrolling

public extension Page {

    @discardableResult
    func scroll(to keyPath: KeyPath<Self, XCUIElement>) -> Self {
        screen
            .scrollTo(element: self[keyPath: keyPath])

        return self
    }
}

// MARK: Utils

public extension Page {

    @discardableResult
    func waitForAppearance(timeout: TimeInterval = .timeout, file: StaticString, line: UInt) -> Self {
        verifyElement(\.screen, using: [.isHittable], timeout: timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func waitForDisappearance(timeout: TimeInterval = .timeout, file: StaticString, line: UInt) -> Self {
        if screen.exists {
            verifyElement(\.screen, using: [.isNotHittable], timeout: timeout, file: file, line: line)
        }

        return self
    }

    @discardableResult
    func swipeUp() -> Self {
        app.swipeUp()

        return self
    }

    @discardableResult
    func swipeDown() -> Self {
        app.swipeDown()

        return self
    }

    @discardableResult
    func panUp(by points: CGFloat = 100) -> Self {
        let coordinates = app.centerCoordinate.withOffset(.init(dx: 0, dy: -points))

        app.centerCoordinate.press(forDuration: 0.2, thenDragTo: coordinates)

        return self
    }

    @discardableResult
    func panDown(by points: CGFloat = 100) -> Self {
        panUp(by: -points)
    }

    @discardableResult
    func elementQuery(_ keyPath: KeyPath<Self, XCUIElementQuery>, identifier: String) -> XCUIElement {
        self[keyPath: keyPath]
            .matching(identifier: identifier)
            .firstMatch
    }

    @discardableResult
    func elementQuery(_ keyPath: KeyPath<Self, XCUIElementQuery>, atIndex index: Int) -> XCUIElement {
        self[keyPath: keyPath]
            .element(boundBy: index)
    }

    @discardableResult
    func elementQuery(_ keyPath: KeyPath<Self, XCUIElementQuery>, predicate: Predicate) -> XCUIElement {
        // swiftlint:disable first_where
        self[keyPath: keyPath]
            .filter(using: predicate)
            .firstMatch
    }

    @discardableResult
    func elementQueryDescendants(_ keyPath: KeyPath<Self, XCUIElementQuery>, identifier: String, type: XCUIElement.ElementType = .any) -> XCUIElement {
        self[keyPath: keyPath]
            .descendants(matching: type)
            .matching(identifier: identifier)
            .firstMatch
    }
}

// MARK: Verifications

public extension Page {

    @discardableResult
    func verifyElementQuery(_ keyPath: KeyPath<Self, XCUIElementQuery>, using predicates: [Predicate], file: StaticString, line: UInt) -> Self {
        validator.verify(self[keyPath: keyPath], using: predicates, timeout: .timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func verifyElement(_ keyPath: KeyPath<Self, XCUIElement>,
                       using predicates: [Predicate],
                       timeout: TimeInterval = .timeout,
                       file: StaticString,
                       line: UInt) -> Self {
        validator.verify(self[keyPath: keyPath], using: predicates, timeout: .timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func isTextFieldValid(_ keyPath: KeyPath<Self, TextFieldPage>, using predicates: [Predicate], timeout: TimeInterval = .timeout) -> Bool {
        validator.validate(self[keyPath: keyPath].screen, using: predicates, timeout: timeout)
    }

    @discardableResult
    func isElementValid(_ keyPath: KeyPath<Self, XCUIElement>, using predicates: [Predicate], timeout: TimeInterval = .timeout) -> Bool {
        validator.validate(self[keyPath: keyPath], using: predicates, timeout: timeout)
    }

    @discardableResult
    func isElementQueryValid(_ keyPath: KeyPath<Self, XCUIElementQuery>,
                             identifier: String,
                             type: XCUIElement.ElementType = .any,
                             predicates: [Predicate],
                             timeout: TimeInterval = .timeout) -> Bool {
        let element = elementQueryDescendants(keyPath, identifier: identifier, type: type)

        return validator.validate(element, using: predicates, timeout: timeout)
    }
}
