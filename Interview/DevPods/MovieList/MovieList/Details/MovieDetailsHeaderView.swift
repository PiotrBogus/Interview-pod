
import Utils
import UIKit
import Shared
import Kingfisher

final class MovieDetailsHeaderView: BaseView {
    
    private enum Constants {
        static let imageHeight: CGFloat = 150
    }
    
    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(size: 15, weight: .bold)))
    private let yearLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline)))
    
    func fill(title: String, imageURL: String, year: String) {
        titleLabel.text = title
        yearLabel.text = year

        if let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url)
        }
    }
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        imageView.contentMode = .scaleAspectFit
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
            imageView,
            titleLabel,
            yearLabel
        ])
    }
    
    override func setUpConstraints() {
        setUpImageViewConstraints()
        setUpTitleLabelConstraints()
        setUpYearLabelConstraints()
    }
    
    private func setUpImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: CGRect.screenBounds.width / 2)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: yearLabel.topAnchor)
        ])
    }
    
    private func setUpYearLabelConstraints() {
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            yearLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -.marginSmall)
        ])
    }
}
