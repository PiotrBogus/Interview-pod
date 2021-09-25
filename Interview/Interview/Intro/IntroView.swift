
import Utils
import UIKit

protocol IntroViewDelegate: AnyObject {
    func didTapWebsiteButton()
    func didTapEnterButton()
}

final class IntroView: BaseView {
    
    private enum Constants {
        static let logoImageSize = CGSize(width: 100, height: 100)
        static let componentsWidth: CGFloat = 256
    }
    
    weak var delegate: IntroViewDelegate?
    
    private let websiteButton = BaseButton(configuration: .flat)
    private let logoImage = UIImageView(image: .movie)
    private let titleLabel = BaseLabel(configuration: TextConfiguration(text: "intro_screen_title".localized, textColor: .whiteColor, font: .font(.title1), textAlignment: .center))
    private let subtitleLabel = BaseLabel(configuration: TextConfiguration(text: "intro_screen_subtitle".localized, textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    private let enterButton = BaseButton(configuration: .main)
    private let legalInfoTextView = InfoTextView()
    
    override func setUpViewsHierarchy() {
        addSubviews([websiteButton,
                     logoImage,
                     titleLabel,
                     subtitleLabel,
                     enterButton,
                     legalInfoTextView])
    }
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        setUpWebsiteButton()
        setUpEnterButton()
        setUpLegalInfoTextView()
    }
    
    override func setUpConstraints() {
        setUpWebsiteButtonConstraints()
        setUpLogoImageConstraints()
        setUpTitleLabelConstraints()
        setUpSubtitleLabelConstraints()
        setUpEnterButtonConstraints()
        setUpLegalInfoTextViewConstraints()
    }
    
    private func setUpWebsiteButtonConstraints() {
        websiteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            websiteButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            websiteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginLarge)
        ])
    }
    
    private func setUpLogoImageConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(greaterThanOrEqualTo: websiteButton.bottomAnchor, constant: .marginExtraLarge2),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: Constants.logoImageSize.height),
            logoImage.widthAnchor.constraint(equalToConstant: Constants.logoImageSize.width),
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: .marginExtraLarge2),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.componentsWidth),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setUpSubtitleLabelConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .marginExtraLarge2),
            subtitleLabel.widthAnchor.constraint(equalToConstant: Constants.componentsWidth),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setUpEnterButtonConstraints() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            enterButton.widthAnchor.constraint(equalToConstant: Constants.componentsWidth),
            enterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            enterButton.topAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor, constant: .marginExtraLarge4),
            enterButton.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
    }
    
    private func setUpLegalInfoTextViewConstraints() {
        legalInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            legalInfoTextView.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: .marginLarge),
            legalInfoTextView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -.marginLarge),
            legalInfoTextView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setUpLegalInfoTextView() {
        let disclaimer = DisclaimerInfoTextHelper(infoString: "intro_screen_privacy".localized, termsOfUseLinkString: "intro_screen_underlined_part_two".localized, privacyPolicyLinkString: "intro_screen_underlined_part_one".localized)
        legalInfoTextView.attributedText = disclaimer.makeInfoText()
        legalInfoTextView.linkTextAttributes = disclaimer.makeLinkTextAttributes()
        legalInfoTextView.delegate = self
    }
    
    private func setUpWebsiteButton() {
        websiteButton.setTitle("intro_screen_website_button_title".localized, for: .normal)
        websiteButton.addTarget(self, action: #selector(didTapWebsiteButton), for: .touchUpInside)
    }
    
    private func setUpEnterButton() {
        enterButton.setTitle("intro_screen_button_title".localized, for: .normal)
        enterButton.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
    }
    
    @objc private func didTapWebsiteButton() {
        delegate?.didTapWebsiteButton()
    }
    
    @objc private func didTapEnterButton() {
        delegate?.didTapEnterButton()
    }
}

extension IntroView: UITextViewDelegate {}
