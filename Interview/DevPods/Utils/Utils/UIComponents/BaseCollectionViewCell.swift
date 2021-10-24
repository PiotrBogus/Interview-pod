
import UIKit
import Shared

open class BaseCollectionViewCell: UICollectionViewCell, ReusableView, View {
    
    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }

    open func setUp() {
        performSetUp()
    }

    open func setUpViewsHierarchy() {}

    open func setUpConstraints() {}

    open func setUpSubviews() {}

    open func setUpAccessibilityIdentifiers() {}
}
