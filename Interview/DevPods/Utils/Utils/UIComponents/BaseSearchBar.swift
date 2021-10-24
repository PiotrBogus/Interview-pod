
import Foundation
import UIKit
import Shared

open class BaseSearchBar: UISearchBar, View {
    
    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }
    public func setUpViewsHierarchy() {}
    
    public func setUpConstraints() {}
    
    public func setUpSubviews() {}
    
    public func setUpAccessibilityIdentifiers() {}
}
