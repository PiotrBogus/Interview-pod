
import UIKit
import Shared

open class BaseView: UIView, View {

    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)

        setUp()
    }

    public init() {
        super.init(frame: .componentBounds)

        setUp()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setUp() {
        backgroundColor = .whiteColor
        performSetUp()
    }

    open func setUpViewsHierarchy() {}

    open func setUpConstraints() {}

    open func setUpSubviews() {}

    open func setUpAccessibilityIdentifiers() {}

    override open func layoutSubviews() {
        super.layoutSubviews()
    }

    override open func didMoveToWindow() {
        defer { super.didMoveToWindow() }

        guard window != nil else { return }

        traitCollectionDidChange(nil)
    }
}
