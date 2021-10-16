
import Foundation
import XCTest

protocol Steps: AnyObject {
    associatedtype PageType: Page

    var page: PageType { get }
    var factory: PageFactory { get }
}

extension Steps {

    @discardableResult
    func waitForAppearance(timeout: TimeInterval = .timeout, file: StaticString, line: UInt) -> Self {
        page.waitForAppearance(timeout: timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func waitForDisappearance(timeout: TimeInterval = .timeout, file: StaticString, line: UInt) -> Self {
        page.waitForDisappearance(timeout: timeout, file: file, line: line)

        return self
    }

    @discardableResult
    func tapKeyboardReturn(file: StaticString, line: UInt) -> Self {
        page
            .tapKeyboardReturn(file: file, line: line)

        return self
    }

    @discardableResult
    func tapBackButton() -> Self {
        page
            .tapBackButton()

        return self
    }
}

// MARK: - Tabs

extension Steps {

    private var tabBarPage: TabBarPage { factory.tabBar }

//    @discardableResult
//    func tapMoreOptionsTab(file: StaticString, line: UInt) -> Self {
//        tabBarPage
//            .waitForAppearance(file: file, line: line)
//            .tap(\.optionTab)
//
//        return self
//    }
}

// MARK: - Toast

extension Steps {

    private var toastPage: ToastPage { factory.toast }

    @discardableResult
    func waitForToastDisappearance(file: StaticString, line: UInt) -> Self {
        toastPage
            .waitForDisappearance(file: file, line: line)

        return self
    }

    @discardableResult
    func waitForToastAppearance(file: StaticString, line: UInt) -> Self {
        toastPage
            .waitForAppearance(file: file, line: line)

        return self
    }
}

// MARK: - Minimize

extension Steps where PageType: MinimizablePage {

    @discardableResult
    func minimizeApp() -> Self {
        page
            .pressHome()

        return self
    }

    @discardableResult
    func sleepBackgroundApp() -> Self {
        page
            .wait(timeout: .backgroundTime)

        return self
    }

    @discardableResult
    func restoreApp() -> Self {
        page
            .activate()

        return self
    }
}
