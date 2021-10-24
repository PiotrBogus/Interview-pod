
import UIKit

private let screenSize = UIScreen.main.bounds

public extension CGRect {

    static let screenBounds = screenSize

    static let componentBounds = CGRect(origin: .zero,
                                        size: CGSize(width: screenBounds.width, height: 48))

    static let minimalSupportedScreen = CGRect(origin: .zero,
                                               size: CGSize(width: 320.0, height: 568.0))
}
