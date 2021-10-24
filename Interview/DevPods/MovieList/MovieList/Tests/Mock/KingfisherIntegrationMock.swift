
import Foundation
import UIKit
import Utils

final class KingfisherIntegrationMock: KingfisherIntegrationProtocol {

    private var didLoadAsyncImage: Bool = false
    
    func loadAsyncImage(from url: URL, to imageView: UIImageView) {
        didLoadAsyncImage = true
    }
}
