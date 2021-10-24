
import UIKit

public struct ButtonConfiguration {

    public var cornerRadius: CGFloat

    // Colors
    public var backgroundColor: UIColor
    public var labelsColor: UIColor

    // Border
    public var borderWidth: CGFloat
    public var borderColor: UIColor

    // Fonts
    public var font: UIFont

    public init(cornerRadius: CGFloat,
                backgroundColor: UIColor,
                labelsColor: UIColor,
                borderWidth: CGFloat,
                borderColor: UIColor,
                font: UIFont) {
        self.cornerRadius = cornerRadius
        self.labelsColor = labelsColor
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.font = font
    }
}

public extension ButtonConfiguration {

    static let main = ButtonConfiguration(
        cornerRadius: .buttonCornerRadius,
        backgroundColor: .redColor,
        labelsColor: .whiteColor,
        borderWidth: .zero,
        borderColor: .redColor,
        font: .font(.body)
    )
    
    static let flat = ButtonConfiguration(
        cornerRadius: .zero,
        backgroundColor: .clearColor,
        labelsColor: .whiteColor,
        borderWidth: .zero,
        borderColor: .clearColor,
        font: .font(.headline)
    )
}
