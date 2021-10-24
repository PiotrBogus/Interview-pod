
import Foundation
import UIKit

public extension UIImage {
    
    func resized(to targetSize: CGSize, screenScale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let size = self.size

        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio * screenScale, height: size.height * ratio * screenScale)

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
