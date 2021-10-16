
import Shared
import UITestsCore
import XCTest

extension AnyObjectElementValidator {

    static let `default` = AnyElementValidator(validator: DefaultElementValidator<NSObject>())
}

extension Page {

    var validator: AnyObjectElementValidator { .default }
}

extension TextFieldPage {

    convenience init(id: String, app: XCUIApplication, type: XCUIElement.ElementType = .textField) {
        self.init(id: id, app: app, type: type, validator: .default)
    }

    convenience init(id: UIElementIdentifier, app: XCUIApplication, type: XCUIElement.ElementType = .textField) {
        self.init(id: id.id, app: app, type: type, validator: .default)
    }
}

extension KeyboardPage {

    convenience init(app: XCUIApplication) {
        self.init(app: app, validator: .default)
    }
}
