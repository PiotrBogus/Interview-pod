
import Foundation
import UIKit
import Utils

struct MovieDetailsAdditionalnformationTextFormatter {
    
    func prepareText(title: String?, description: String?) -> NSAttributedString? {
        guard let title = title,
              let description = description else { return nil }
        
        let fullText = "\(title): \(description)"
        
        let titleRange = (fullText as NSString).range(of: title)
        let descriptionRange = (fullText as NSString).range(of: description)
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.setAttributes([.font: UIFont.font(size: 15, weight: .semibold)], range: titleRange)
        attributedString.setAttributes([.font: UIFont.font(.subheadline)], range: descriptionRange)
        
        return attributedString
    }
}
