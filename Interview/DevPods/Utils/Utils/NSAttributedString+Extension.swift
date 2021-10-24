
import Foundation
import UIKit

public extension NSAttributedString {
    
    var hasImage: Bool {
        var hasImage = false
        let fullRange = NSRange(location: 0, length: self.length)
        
        self.enumerateAttribute(NSAttributedString.Key.attachment, in: fullRange, options: []) { (value, _, _) in
            guard let attachment = value as? NSTextAttachment else { return }
            
            if let _ = attachment.image {
                hasImage = true
            }
        }
        
        return hasImage
    }
}
