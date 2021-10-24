
import Foundation
import UIKit
import Utils

struct MovieDetailsRatingViewTextFormatter {
    
    func preparePlotText(plot: String?) -> NSAttributedString? {
        guard let plot = plot else { return nil }
        
        let fullText = "\("movie_details_synopsis".localized)\n\(plot)"
        
        let synopsisRange = (fullText as NSString).range(of: "movie_details_synopsis".localized)
        let plotRange = (fullText as NSString).range(of: plot)
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.setAttributes([.font: UIFont.font(size: 15, weight: .semibold)], range: synopsisRange)
        attributedString.setAttributes([.font: UIFont.font(.subheadline)], range: plotRange)
        
        return attributedString
    }
    
    func prepareText(with leftImage: UIImage, text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let image = leftImage.resized(to: CGSize(width: 6, height: 6))
        image?.withRenderingMode(.alwaysTemplate)
        image?.withTintColor(.whiteColor)
        
        let attachment = NSTextAttachment(image: image!)
        let attributedStringWithImage = NSMutableAttributedString(attachment: attachment)
        attributedStringWithImage.append(NSAttributedString(string: text, attributes: [.font: UIFont.font(.subheadline)]))
        
        return attributedStringWithImage
    }
    
    func prepare2LinesText(with title: String?, description: String?) -> NSAttributedString? {
        guard let title = title,
              let description = description else { return nil }
        
        let fullText = "\(title)\n\(description)"
        
        let titleRange = (fullText as NSString).range(of: title)
        let descriptionRange = (fullText as NSString).range(of: description)
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.setAttributes([.font: UIFont.font(size: 15, weight: .semibold)], range: titleRange)
        attributedString.setAttributes([.font: UIFont.font(.subheadline)], range: descriptionRange)
        
        return attributedString
    }
}
