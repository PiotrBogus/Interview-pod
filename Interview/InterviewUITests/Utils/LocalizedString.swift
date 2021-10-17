
import Foundation

final class LocalizedString {

    private static var currentLanguage: String = {
        let currentLocale = Locale(identifier: Locale.preferredLanguages.first!)

        return currentLocale.languageCode ?? "en"
    }()

    static func string(key: String) -> String {
        let bundle = Bundle(for: LocalizedString.self)
        guard let localizedBundlePath = bundle.path(forResource: currentLanguage, ofType: "lproj"),
              let localizedBundle = Bundle(path: localizedBundlePath) else {
            return key
        }

        return NSLocalizedString(key, bundle: localizedBundle, comment: "")
    }
}
