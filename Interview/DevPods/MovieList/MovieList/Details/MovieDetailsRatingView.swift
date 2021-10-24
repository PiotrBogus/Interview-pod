
import Foundation
import Utils
import UIKit

final class MovieDetailsRatingView: BaseView {
    
    private let topHorizontalStackView = UIStackView()
    private let categoriesLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    private let durationLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    private let starLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    
    private let plotLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline)))
    
    private let bottomHorizontalStackView = UIStackView()
    private let scoreLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    private let reviewsLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    private let popularityLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline), textAlignment: .center))
    
    private let topSeparatorView = BaseView()
    private let bottomSeparatorView = BaseView()
    
    private let textFormatter = MovieDetailsRatingViewTextFormatter()

    func fill(categories: String?, duration: String?, plot: String?, rate: String?, reviews: String?, popularity: String?) {
        categoriesLabel.text = categories
        starLabel.attributedText = MovieDetailsRatingViewTextFormatter().prepareText(with: .star!, text: rate)
        durationLabel.text = duration
        plotLabel.attributedText = textFormatter.preparePlotText(plot: plot)
        scoreLabel.attributedText = textFormatter.prepare2LinesText(with: "movie_details_score".localized, description: rate)
        reviewsLabel.attributedText =  textFormatter.prepare2LinesText(with: "movie_details_reviews".localized, description: reviews)
        popularityLabel.attributedText =  textFormatter.prepare2LinesText(with: "movie_details_popularity".localized, description: popularity)
    }
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        topSeparatorView.backgroundColor = .whiteColor
        bottomSeparatorView.backgroundColor = .whiteColor
        topHorizontalStackView.axis = .horizontal
        bottomHorizontalStackView.axis = .horizontal
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
            topSeparatorView,
            topHorizontalStackView,
            plotLabel,
            bottomHorizontalStackView,
            bottomSeparatorView
        ])
        
        topHorizontalStackView.addArrangedSubview(categoriesLabel)
        topHorizontalStackView.addArrangedSubview(durationLabel)
        topHorizontalStackView.addArrangedSubview(starLabel)
        
        bottomHorizontalStackView.addArrangedSubview(scoreLabel)
        bottomHorizontalStackView.addArrangedSubview(reviewsLabel)
        bottomHorizontalStackView.addArrangedSubview(popularityLabel)
    }

    override func setUpConstraints() {
        setUpTopSeaparatorViewConstraints()
        setUpTopHorizontalStackViewConstraints()
        setUpPlotLabelConstraints()
        setUpBottomHorizontalStackViewConstraints()
        setUpBottomSeaparatorViewConstraints()
    }
    
    private func setUpTopSeaparatorViewConstraints() {
        topSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: .separatorHeight)
        ])
    }
    
    private func setUpTopHorizontalStackViewConstraints() {
        topHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topHorizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: .marginSmall),
            topHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            topHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall),
        ])
    }
    
    private func setUpPlotLabelConstraints() {
        plotLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            plotLabel.topAnchor.constraint(equalTo: topHorizontalStackView.bottomAnchor, constant: .marginLarge),
            plotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            plotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall)
        ])
    }
    
    private func setUpBottomHorizontalStackViewConstraints() {
        bottomHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomHorizontalStackView.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: .marginLarge),
            bottomHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            bottomHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall),
            bottomHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.marginSmall),
        ])
    }
    
    private func setUpBottomSeaparatorViewConstraints() {
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: .separatorHeight)
        ])
    }
}
