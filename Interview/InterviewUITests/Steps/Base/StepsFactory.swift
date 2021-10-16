
import XCTest

final class StepsFactory {

    let snapShooter: SnapShooter?
    let app: XCUIApplication
    let test: XCTestCase

    private(set) lazy var factory = PageFactory(snapShooter: snapShooter, app: app, test: test)

    private(set) lazy var intro = IntroSteps(factory: factory)
    private(set) lazy var movieList = MovieListSteps(factory: factory)

    init(app: XCUIApplication, test: XCTestCase, snapShooter: SnapShooter?) {
        self.app = app
        self.test = test
        self.snapShooter = snapShooter
    }
}
