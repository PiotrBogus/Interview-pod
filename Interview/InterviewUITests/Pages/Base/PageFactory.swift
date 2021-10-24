
import XCTest

final class PageFactory {

    let app: XCUIApplication
    let test: XCTestCase
    private let snapShooter: SnapShooter?

    private lazy var safariApp = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")

    private(set) lazy var sharedWebCredential = SharedWebCredentialPage(app: app, test: test)
    private(set) lazy var keyboard = KeyboardPage(app: app)
    private(set) lazy var toast = ToastPage(app: app)
    private(set) lazy var tabBar = TabBarPage(app: app)
    private(set) lazy var intro = IntroPage(app: app)
    private(set) lazy var movieList = MovieListPage(app: app)

    init(snapShooter: SnapShooter?, app: XCUIApplication, test: XCTestCase) {
        self.snapShooter = snapShooter
        self.app = app
        self.test = test
    }
}
