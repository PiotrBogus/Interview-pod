
import UIKit
import Shared

public protocol View: UIView {

    var elementIdentifier: UIElementIdentifier? { get set }

    func setUpViewsHierarchy()
    func setUpConstraints()
    func setUpSubviews()
    func setUpAccessibilityIdentifiers()
}

public extension View {

    func performSetUp() {
        setUpSubviews()
        setUpViewsHierarchy()
        setUpConstraints()
        setUpAccessibilityIdentifiers()
    }
}
