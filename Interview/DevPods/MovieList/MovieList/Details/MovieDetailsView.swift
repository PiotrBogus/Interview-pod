
import Utils
import UIKit
import Shared

protocol MovieDetailsViewDelegate: AnyObject {
    func didTapRetryButton()
}

final class MovieDetailsView: BaseView {
    
    private enum Constants {
        static let closeButtonSize = CGSize(width: 20, height: 20)
        static let headerHeight: CGFloat = 150
    }
    
    weak var delegate: MovieDetailsViewDelegate?
    
    private var movie: Movie
    private let scrollView = UIScrollView()
    private let containerView = BaseView()
    private let headerView = MovieDetailsHeaderView()
    private let ratingView = MovieDetailsRatingView()
    private let additionalInformationView = MovieDetailsAdditionalnformationView()
    private let activityIindicator = UIActivityIndicatorView(style: .large)
    private let retryView = MovieDetailsRetryView()

    init(movie: Movie) {
        self.movie = movie
        
        super.init()
    }
    
    func retryView(isHidden: Bool) {
        isHidden ? hideRetryView() : showRetryView()
    }
    
    func loader(isHidden: Bool) {
        if isHidden {
            activityIindicator.stopAnimating()
            ratingView.isHidden = false
            additionalInformationView.isHidden = false
        } else {
            activityIindicator.startAnimating()
            ratingView.isHidden = true
            additionalInformationView.isHidden = true
        }
    }
    
    func fill(with movie: Movie) {
        headerView.fill(title: movie.title, imageURL: movie.poster, year: movie.year)
        ratingView.fill(categories: movie.type.rawValue, duration: movie.runtime, plot: movie.plot, rate: movie.imdbRating, reviews: movie.imdbVotes, popularity: movie.metascore)
        additionalInformationView.fill(director: movie.director, writer: movie.writer, actors: movie.actors)
    }
    
    override func setUpSubviews() {
        backgroundColor = .introBackgroundColor
        containerView.backgroundColor = .introBackgroundColor
        scrollView.isScrollEnabled = true
        activityIindicator.color = .whiteColor
        activityIindicator.hidesWhenStopped = true
        headerView.fill(title: movie.title, imageURL: movie.poster, year: movie.year)
        retryView.delegate = self
    }
    
    override func setUpViewsHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews([
            headerView,
            ratingView,
            additionalInformationView,
            activityIindicator,
        ])
    }
    
    override func setUpConstraints() {
        setUpScrollViewConstraints()
        setUpContainerViewConstraints()
        setUpHeaderViewConstraints()
        setUpRatingViewConstraints()
        setUpAdditionalInformationViewConstraints()
        setUpActivityIindicatorConstraints()
    }
    
    private func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setUpContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setUpHeaderViewConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }
    
    private func setUpRatingViewConstraints() {
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: .marginExtraSmall),
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpAdditionalInformationViewConstraints() {
        additionalInformationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            additionalInformationView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: .marginExtraSmall),
            additionalInformationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            additionalInformationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            additionalInformationView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
    
    private func setUpActivityIindicatorConstraints() {
        activityIindicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIindicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIindicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func showRetryView() {
        addSubview(retryView)
        
        retryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            retryView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            retryView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            retryView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            retryView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    private func hideRetryView() {
        retryView.removeFromSuperview()
    }
}

extension MovieDetailsView: MovieDetailsRetryViewDelegate {
    
    func didTapRetryButton() {
        delegate?.didTapRetryButton()
    }
}
