
import Foundation
import UIKit

public extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func height(width: CGFloat = UIScreen.main.bounds.width, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
    
    func trimmed(_ characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        trimmingCharacters(in: characterSet)
    }
}
