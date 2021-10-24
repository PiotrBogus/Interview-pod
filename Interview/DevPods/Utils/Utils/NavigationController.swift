
import UIKit

open class NavigationController: UINavigationController {

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        delegate = self
        interactivePopGestureRecognizer?.delegate = nil
        
        updateNavigationBarAppearance()
    }
    
    open func updateNavigationBarAppearance() {
        navigationBar.shadowImage = nil

        navigationBar.barTintColor = .introBackgroundColor
        view.backgroundColor = .introBackgroundColor
        navigationBar.tintColor = .whiteColor
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.whiteColor,
        ]

        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        removeBorderFromNavigationBar()
    }

    open func removeBorderFromNavigationBar() {
        navigationBar.shadowImage = UIImage()
    }
}

extension NavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
