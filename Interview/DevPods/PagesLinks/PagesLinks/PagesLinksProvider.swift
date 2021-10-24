
public protocol PagesLinksProviding {
    func getPrivacyPolicyLink() -> String?
    func getTermsOfUseLink() -> String?
}

final class PagesLinksProvider: PagesLinksProviding {
    
    private let linksSet: PagesLinksSet
    
    init(linksSet: PagesLinksSet) {
        self.linksSet = linksSet
    }
    
    func getPrivacyPolicyLink() -> String? {
        linksSet.privacyPolicyLinks
    }
    
    func getTermsOfUseLink() -> String? {
        linksSet.termsOfUseLinks
    }
}
