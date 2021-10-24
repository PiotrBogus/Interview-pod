
import UIKit
import Shared

open class BaseButton: UIButton, View {
    
    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }
    
    private let config: ButtonConfiguration
    
    public init(configuration: ButtonConfiguration) {
        self.config = configuration
        
        super.init(frame: .zero)
        
        setUp()
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setUp() {
        setTitleColor(config.labelsColor, for: .normal)
        titleLabel?.font = config.font
        backgroundColor = config.backgroundColor
        layer.cornerRadius = config.cornerRadius
        layer.borderWidth = config.borderWidth
        layer.borderColor = config.borderColor.cgColor
        
        performSetUp()
    }
    
    open func setUpViewsHierarchy() {}
    
    open func setUpConstraints() {}
    
    open func setUpSubviews() {}

    open func setUpAccessibilityIdentifiers() {}
}
