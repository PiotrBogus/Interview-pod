
import XCTest

public final class KeyboardPage: Page {

    public let id = ""
    public let app: XCUIApplication
    public let validator: AnyObjectElementValidator

    public var type: XCUIElement.ElementType { .keyboard }
    public var deleteKey: String { XCUIKeyboardKey.delete.rawValue }
    public var returnKey: XCUIElement { screen.buttons.lastMatch }
    public var shift: XCUIElement { screen.buttons["shift"].firstMatch }

    public init(app: XCUIApplication, validator: AnyObjectElementValidator) {
        self.app = app
        self.validator = validator
    }

    @discardableResult
    public func tapReturn() -> KeyboardPage {
        tap(\.returnKey)

        return self
    }

    @discardableResult
    public func tap(key: String) -> Self {
        app.keys[key].tap()

        return self
    }

    @discardableResult
    public func type(value: String, file: StaticString, line: UInt) -> Self {
        value.map(String.init).forEach { tap(key: $0) }

        return self
    }
}
