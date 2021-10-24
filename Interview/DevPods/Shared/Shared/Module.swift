
import Foundation

public enum Module: String, CaseIterable {
    case appProduct = "Interview"
    case uITests = "InterviewUITests"

    public var bundle: Bundle {
        mainBundle.moduleBundle(module: self)
            ?? Bundle(identifier: bundleName)
            ?? Bundle(identifier: unitTestsBundleName)
            ?? mainBundle
    }

    var bundleName: String { "com.stepstone.\(rawValue)" }
    var unitTestsBundleName: String { "org.cocoapods.\(rawValue)-Unit-Tests" }

    var mainBundle: Bundle {
        isUITests ? .uiTests ?? .main : .main
    }

    var isUITests: Bool { [.uITests].contains(self) }
}

public extension Bundle {

    static var uiTestsResources: Bundle {
        let bundles = Module.allCases.filter(\.isUITests).map(\.bundle)

        return bundles.first(where: { $0.bundlePath.hasSuffix("xctest") == false }) ?? bundles[0]
    }
}

private extension Bundle {

    func moduleBundle(module: Module) -> Bundle? {
        guard let url = self.url(forResource: module.bundleName, withExtension: "bundle") else { return nil }

        return Bundle(url: url)
    }

    static var uiTests: Bundle? {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }

        let nameOfTestBundle = bundleName.split(separator: "-").dropLast().joined(separator: "-")

        return allBundles.first { $0.isLoaded && $0.bundlePath.hasSuffix("\(nameOfTestBundle).xctest") }
    }
}
