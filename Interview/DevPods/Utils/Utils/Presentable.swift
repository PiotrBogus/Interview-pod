
import UIKit

public protocol Presentable: AnyObject {}

public extension Presentable {

    func present(viewController: UIViewController, on currentController: UIViewController) {
        if currentController.view.traitCollection.horizontalSizeClass == .regular {
            present(asModal: viewController, on: currentController)
        } else {
            viewController.hidesBottomBarWhenPushed = true
            push(viewController: viewController, on: currentController)
        }
    }

    func present(asModal viewController: UIViewController, on currentController: UIViewController) {
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .formSheet

        currentController.present(navigationController, animated: true)
    }

    func push(viewController: UIViewController, on currentController: UIViewController) {
        if let navController = currentController as? UINavigationController {
            navController.pushViewController(viewController, animated: true)
        } else {
            currentController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
