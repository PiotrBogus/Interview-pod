
import Foundation
import Utils
import UIKit

protocol MovieDetailsRetryViewDelegate: AnyObject {
    func didTapRetryButton()
}

final class MovieDetailsRetryView: BaseView {
    
    private enum Constants {
        static let imageSize = CGSize(width: 50, height: 50)
        static let color = UIColor.whiteColor.withAlphaComponent(0.75)
    }
    
    weak var delegate: MovieDetailsRetryViewDelegate?
    
    private let imageView = UIImageView(image: .refresh?.withRenderingMode(.alwaysTemplate))
    private let titleLabel = BaseLabel(configuration: TextConfiguration(textColor: Constants.color, font: .font(.subheadline), textAlignment: .center))
    private let retryButton = BaseButton(configuration: .main)
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        imageView.tintColor = Constants.color
        titleLabel.text = "retry_description".localized
        setUpRetryButton()
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
            imageView,
            titleLabel,
            retryButton
        ])
    }
    
    override func setUpConstraints() {
        setUpImageViewConstraints()
        setUpTitleLabelConstraints()
        setUpRetryButtonConstraints()
    }
    
    private func setUpImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .marginExtraLarge3),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .marginLarge),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginLarge),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginLarge)
        ])
    }
    
    private func setUpRetryButtonConstraints() {
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            retryButton.heightAnchor.constraint(equalToConstant: .buttonHeight),
            retryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginExtraLarge3),
            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginExtraLarge3),
            retryButton.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: .marginLarge),
            retryButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
    
    private func setUpRetryButton() {
        retryButton.setTitle("retry_button_title".localized, for: .normal)
        retryButton.setTitleColor(.whiteColor, for: .normal)
        retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        retryButton.backgroundColor = .redColor
    }
    
    @objc private func didTapRetryButton() {
        delegate?.didTapRetryButton()
    }
}
