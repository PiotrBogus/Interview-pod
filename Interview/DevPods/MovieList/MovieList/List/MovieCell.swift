
import UIKit
import Utils
import Shared
import Kingfisher

final class MovieCell: BaseCollectionViewCell {
    
    private let titleLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.footnote)))
    private let imageView = UIImageView()
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        guard let url = URL(string: movie.poster) else { return }
        
        imageView.kf.setImage(with: url)
    }
    
    override func setUpSubviews() {
        contentView.backgroundColor = .redColor
    }
    
    override func setUpViewsHierarchy() {
        contentView.addSubviews([imageView,
                                 titleLabel])
    }
    
    override func setUpConstraints() {
        setUpImageViewConstraints()
        setUpTitleLabelConstraints()
    }

    private func setUpImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.marginSmall),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .marginSmall),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.marginSmall)
        ])
    }
}
