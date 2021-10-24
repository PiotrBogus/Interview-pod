
import Foundation
import UIKit
import Utils

final class MovieDetailsAdditionalnformationView: BaseView {
    
    private let directorLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline)))
    private let writerLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline)))
    private let actorsLabel = BaseLabel(configuration: TextConfiguration(textColor: .whiteColor, font: .font(.subheadline)))
    
    private let textFormatter = MovieDetailsAdditionalnformationTextFormatter()
    
    func fill(director: String?, writer: String?, actors: String?) {
        directorLabel.attributedText = textFormatter.prepareText(title: "movie_details_director".localized,
                                                                 description: director)
        writerLabel.attributedText = textFormatter.prepareText(title: "movie_details_writer".localized,
                                                               description: writer)
        actorsLabel.attributedText = textFormatter.prepareText(title: "movie_details_actors".localized,
                                                               description: actors)
    }
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
    }
    
    override func setUpViewsHierarchy() {
        addSubviews([
        directorLabel,
            writerLabel,
            actorsLabel
        ])
    }
    
    override func setUpConstraints() {
        setUpDirectorLabelConstraints()
        setUpWriterLabelConstraints()
        setUpActorsLabelConstraints()
    }
    
    private func setUpDirectorLabelConstraints() {
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            directorLabel.topAnchor.constraint(equalTo: topAnchor),
            directorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            directorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall)
        ])
    }
    
    private func setUpWriterLabelConstraints() {
        writerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            writerLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: .marginSmall),
            writerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            writerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall)
        ])
    }
    
    private func setUpActorsLabelConstraints() {
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actorsLabel.topAnchor.constraint(equalTo: writerLabel.bottomAnchor, constant: .marginSmall),
            actorsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .marginSmall),
            actorsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.marginSmall),
            actorsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
