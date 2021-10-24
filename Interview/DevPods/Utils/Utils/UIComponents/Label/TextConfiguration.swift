
import UIKit

public struct TextConfiguration {

    public var text: String
    public var textColor: UIColor
    public var font: UIFont
    public let textAlignment: NSTextAlignment
    public let maximumNumberOfLines: Int
    public var attributedText: NSAttributedString?

    public init(text: String? = nil,
                textColor: UIColor = .blackColor,
                font: UIFont = .font(.headline),
                textAlignment: NSTextAlignment = .natural,
                maximumNumberOfLines: Int = 0,
                attributedText: NSAttributedString? = nil) {
        self.text = text ?? ""
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.maximumNumberOfLines = maximumNumberOfLines
        self.attributedText = attributedText
    }
}
