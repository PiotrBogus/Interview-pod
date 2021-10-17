
import Shared
import UITestsCore
import XCTest

extension XCUIApplication {

    subscript<Feature: RawRepresentable>(launchEnvironment feature: Feature) -> Bool where Feature.RawValue == String {
        get {
            launchEnvironment[feature.rawValue]?.lowercased() == "true"
        }

        set {
            launchEnvironment[feature.rawValue] = newValue ? "true" : "false"
        }
    }

    subscript(textField id: UIElementIdentifier) -> TextFieldPage {
        TextFieldPage(id: id.id, app: self, type: id.type.xcElementType)
    }
}
