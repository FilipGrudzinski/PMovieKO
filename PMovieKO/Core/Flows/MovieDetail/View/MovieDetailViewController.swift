import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModel
    
    private struct Constants {
        static let starFill = "star.fill"
        static let star = "star"
        static let defaultMargin: CGFloat = 16.0
        static let smallMargin: CGFloat = 8.0
        static let imageViewMultiplier: CGFloat = 2/3
    }
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(onCancelTapped))
        return button
    }()
    
    lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: Constants.star),
            style: .plain,
            target: self,
            action: #selector(updateFavorite))
        return button
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: UIFont.huge)
        label.textAlignment = .left
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: UIFont.small)
        label.textAlignment = .left
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: UIFont.small)
        label.textAlignment = .left
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: UIFont.normal)
        label.textAlignment = .left
        return label
    }()
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        configure()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = favoriteButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.imageViewMultiplier),
            
            titleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.defaultMargin),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.defaultMargin),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultMargin),
            
            dateLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.smallMargin),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.defaultMargin),
            dateLabel.bottomAnchor.constraint(
                equalTo: descriptionLabel.topAnchor,
                constant: -Constants.defaultMargin),
            
            ratingLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.smallMargin),
            ratingLabel.leadingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor,
                constant: Constants.smallMargin),
            ratingLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultMargin),
            ratingLabel.bottomAnchor.constraint(
                equalTo: descriptionLabel.topAnchor,
                constant: -Constants.defaultMargin),
            
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.defaultMargin),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultMargin),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant:  Constants.defaultMargin),
        ])
    }
    
    private func configure() {
        title = viewModel.title
        titleLabel.text = viewModel.movie.title
        dateLabel.text = viewModel.movie.releaseDate
        ratingLabel.text = "⭐️ \(viewModel.movie.voteAverage)"
        descriptionLabel.text = viewModel.movie.overview
        imageView.kf.setImage(with: viewModel.movie.posterLink)
        
        setFavorite()
    }
    
    @objc private func onCancelTapped() {
        viewModel.onCancelTapped()
    }
    
    @objc private func updateFavorite() {
        viewModel.updateFavorite()
        viewModel.movie.isFavorite.toggle()
        setFavorite()
    }
    
    private func setFavorite() {
        let image = viewModel.movie.isFavorite ? Constants.starFill : Constants.star
        favoriteButton.image = UIImage(systemName: image)
    }
}
