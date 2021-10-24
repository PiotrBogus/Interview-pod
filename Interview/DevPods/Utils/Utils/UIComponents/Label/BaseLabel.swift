
import UIKit
import Shared

open class BaseLabel: UILabel, View {
    
    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }

    private var configuration: TextConfiguration?

    public init(configuration: TextConfiguration) {
        self.configuration = configuration

        super.init(frame: .componentBounds)

        setUp()
    }

    init() {
        super.init(frame: .componentBounds)

        setUp()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setUp() {
        performSetUp()
    }

    open func setUpViewsHierarchy() {}

    open func setUpConstraints() {}

    open func setUpSubviews() {
        guard let configuration = configuration else { return }

        configure(using: configuration)
    }

    open func setUpAccessibilityIdentifiers() {}

    func configure(using configuration: TextConfiguration) {
        self.configuration = configuration

        text = configuration.text
        textColor = configuration.textColor
        font = configuration.font
        textAlignment = configuration.textAlignment
        numberOfLines = configuration.maximumNumberOfLines
        lineBreakMode = numberOfLines > 0 ? .byTruncatingTail : .byWordWrapping

        if let attributedText = configuration.attributedText {
            self.attributedText = attributedText
        }
    }
}
