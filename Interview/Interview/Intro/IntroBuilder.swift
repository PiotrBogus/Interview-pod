
import UIKit

final class IntroBuilder {
    
    func build() -> UIViewController {
        let router = IntroViewRouter()
        let presenter = IntroViewPresenter(router: router)
        let viewController = IntroViewController(presenter: presenter)
        
        return viewController
    }
}
