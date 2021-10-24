
import UIKit

public extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }
    
    func round(corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
    }
}
