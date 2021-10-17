
import Utils
import XCTest

final class SnapshotController {

    let snapShooter: SnapShooter
    private(set) var allowedPages: [Func<PageFactory, Page>] = []

    init(snapShooter: SnapShooter) {
        self.snapShooter = snapShooter
    }

    func append(allowedPages pages: Func<PageFactory, Page>...) -> SnapshotController {
        allowedPages.append(contentsOf: pages)

        return self
    }

    func isAllowed<P: Page>(page: P, in factory: PageFactory) -> Bool {
        allowedPages.first { allowedPage in allowedPage(factory) === page } != nil
    }
}

func get<P: Page>(_ kp: KeyPath<PageFactory, P>) -> (PageFactory) -> Page { { factory in factory[keyPath: kp] } }

prefix func ^ <P: Page>(_ kp: KeyPath<PageFactory, P>) -> (PageFactory) -> Page { { get(kp)($0) } }
