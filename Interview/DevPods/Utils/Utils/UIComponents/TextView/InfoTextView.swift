
import UIKit
import Shared

public class InfoTextView: UITextView {
    
    public var elementIdentifier: UIElementIdentifier? {
        didSet {
            accessibilityIdentifier = elementIdentifier?.id
        }
    }
    
    public var shouldShowEditMenu = false
    
    override public init(frame: CGRect = .zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        
        setUp()
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        shouldShowEditMenu
    }
    
    private func setUp() {
        backgroundColor = .clearColor
        dataDetectorTypes = .link
        isEditable = false
        isScrollEnabled = false
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        textContainer.heightTracksTextView = true
    }
}
