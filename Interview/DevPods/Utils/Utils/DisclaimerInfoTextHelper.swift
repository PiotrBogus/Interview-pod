
import Foundation
import UIKit
import PagesLinks

public final class DisclaimerInfoTextHelper {
    
    private enum Constants {
        static let minimumLineHeight: CGFloat = 16
        static let color = UIColor.whiteColor.withAlphaComponent(0.75)
        static let font: UIFont = .font(.caption1)
    }

    private let infoString: String
    private let termsOfUseLinkString: String
    private let privacyPolicyLinkString: String

    public init(infoString: String,
         termsOfUseLinkString: String,
         privacyPolicyLinkString: String) {
        self.infoString = infoString
        self.termsOfUseLinkString = termsOfUseLinkString
        self.privacyPolicyLinkString = privacyPolicyLinkString
    }

    public func makeInfoText() -> NSAttributedString {
        let infoAttributedString = NSMutableAttributedString(string: infoString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Constants.minimumLineHeight
        let commonAttributes: [NSAttributedString.Key: Any] = [
            .font: Constants.font,
            .foregroundColor: Constants.color,
            .paragraphStyle: paragraphStyle
        ]

        infoAttributedString.setAttributes(commonAttributes, range: NSRange(location: 0, length: infoString.count))

        setUpPrivacyPolicyLink(for: infoAttributedString)
        setUpTermsOfUseLink(for: infoAttributedString)

        return infoAttributedString
    }

    public func makeLinkTextAttributes() -> [NSAttributedString.Key: Any] {
        let linkTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Constants.color,
            NSAttributedString.Key.font: Constants.font
        ]

        return linkTextAttributes
    }

    private func setUpTermsOfUseLink(for infoText: NSMutableAttributedString) {
        let builder = PagesLinksBuilder().build()
        guard let stringURL = builder.getTermsOfUseLink() else {
            return
        }

        let range = (infoText.string as NSString).range(of: termsOfUseLinkString)

        setAttributes(for: infoText, stringURL: stringURL, at: range)
    }
    
    private func setUpPrivacyPolicyLink(for infoText: NSMutableAttributedString) {
        let builder = PagesLinksBuilder().build()
        guard let stringURL = builder.getPrivacyPolicyLink() else {
            return
        }

        let range = (infoText.string as NSString).range(of: privacyPolicyLinkString)

        setAttributes(for: infoText, stringURL: stringURL, at: range)
    }
    
    private func setAttributes(for infoText: NSMutableAttributedString, stringURL: String, at range: NSRange) {
        infoText.setAttributes([.link: stringURL,
                                .underlineStyle: NSUnderlineStyle.single.rawValue,
                                .underlineColor: Constants.color], range: range)
    }
}
