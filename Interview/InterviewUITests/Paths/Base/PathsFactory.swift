
import XCTest

final class PathsFactory {

    let mockupServer: MockupServer!

    let test: XCTestCase
    private let app: XCUIApplication
    private let snapShooter: SnapShooter?

    private(set) lazy var factory = StepsFactory(app: app, test: test, snapShooter: snapShooter)

    private(set) lazy var intro = IntroPaths(factory: factory, mockupServer: mockupServer)
    private(set) lazy var movieList = MovieListPaths(factory: factory, mockupServer: mockupServer)
    
    init(app: XCUIApplication, test: XCTestCase, snapShooter: SnapShooter? = nil, mockupServer: MockupServer? = nil) {
        self.app = app
        self.test = test
        self.snapShooter = snapShooter
        self.mockupServer = mockupServer
    }
}
