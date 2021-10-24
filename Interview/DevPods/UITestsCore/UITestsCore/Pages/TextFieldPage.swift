
import XCTest

public final class TextFieldPage: Page {

    public let app: XCUIApplication
    public let id: String
    public let type: XCUIElement.ElementType
    public let validator: AnyObjectElementValidator

    public var text: String { screen.value as? String ?? "" }
    public var placeholder: String { screen.placeholderValue ?? "" }
    public var hasFocus: Bool { screen.debugDescription.components(separatedBy: "'\(id)'").last?.contains("Focused") ?? false }

    @discardableResult
    public func tapAndWaitForKeyboard(file: StaticString, line: UInt) -> Self {
        guard keyboard.screen.exists == false || hasFocus == false else { return self }

        validator.verify(screen, using: [.isHittable], timeout: .timeout, file: file, line: line)

        screen.tap()

        waitForKeyboard()

        return self
    }

    @discardableResult
    public func forceTap() -> Self {
        screen
            .forceTap()

        return self
    }

    @discardableResult
    public func tap() -> Self {
        screen
            .tap()

        return self
    }

    @discardableResult
    public func type(value: String, file: StaticString, line: UInt) -> Self {
        tapAndWaitForKeyboard(file: file, line: line)

        screen.typeText(value)

        return self
    }

    @discardableResult
    public func clear(file: StaticString, line: UInt) -> Self {
        tapAndWaitForKeyboard(file: file, line: line)

        repeatElement(keyboard.deleteKey, count: text.count)
            .forEach(screen.typeText)

        return self
    }

    public func waitForKeyboard(count: Int = 0, repeats: Int = 6) {
        guard keyboard.screen.waitForExistence(timeout: 0.5) == false || hasFocus == false, count < repeats else { return }

        forceTap()
        waitForKeyboard(count: count + 1, repeats: repeats)
    }

    public init(id: String, app: XCUIApplication, type: XCUIElement.ElementType = .textField, validator: AnyObjectElementValidator) {
        self.id = id
        self.app = app
        self.type = type
        self.validator = validator
    }
}
