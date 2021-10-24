
import Foundation
import UIKit
import Utils

final class MovieListEmptyView: BaseView {
    
    private enum Constants {
        static let color = UIColor.whiteColor.withAlphaComponent(0.75)
        static let imageSize = CGSize(width: 50, height: 50)
    }
    
    private let imageView = UIImageView(image: .movie)
    private let titleLabel = BaseLabel(configuration: TextConfiguration(textColor: Constants.color, font: .font(.subheadline), textAlignment: .center))

    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        titleLabel.text = "empty_movie_list_title".localized
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
            imageView,
            titleLabel
        ])
    }
    
    override func setUpConstraints() {
        setUpImageViewConstraints()
        setUpTitleLabelConstraints()
    }
    
    private func setUpImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .marginSmall),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginExtraLarge3),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginExtraLarge3)
        ])
    }
}
