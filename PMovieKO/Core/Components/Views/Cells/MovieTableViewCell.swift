import UIKit

final class MovieTableViewCell: UITableViewCell {
    private struct Constants {
        static let starFillImage = UIImage(systemName: "star.fill")
        static let starImage = UIImage(systemName: "star")
        static let chevronImageUIImage = UIImage(systemName: "chevron.right")
        static let defaultMargin: CGFloat = 16.0
        static let smallMargin: CGFloat = 8.0
        static let starButtonSize: CGFloat = 20.0
        static let titleFontSize: CGFloat = 17
    }
    
    private var isFavorite: Bool = false
    
    var setFavorite: (() -> Void)?
        
    private lazy var starButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Constants.starImage, for: .normal)
        button.setImage(Constants.starFillImage, for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.chevronImageUIImage
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(starButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            starButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultMargin),
            starButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starButton.heightAnchor.constraint(equalToConstant: Constants.starButtonSize),
            starButton.widthAnchor.constraint(equalToConstant: Constants.starButtonSize),
            titleLabel.leadingAnchor.constraint(equalTo: starButton.trailingAnchor, constant: Constants.defaultMargin),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: chevronImageView.leadingAnchor,
                constant: -Constants.defaultMargin),

            chevronImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.defaultMargin),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starButton.topAnchor.constraint(
                greaterThanOrEqualTo: contentView.topAnchor,
                constant: Constants.defaultMargin),
            chevronImageView.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -Constants.smallMargin)
        ])
    }
    
    func setup(title: String, isFavorite: Bool) {
        titleLabel.text = title
        self.isFavorite = isFavorite
        starButton.isSelected = isFavorite
    }
    
    @objc private func favoriteButtonTap() {
        isFavorite.toggle()
        setFavorite?()
        starButton.isSelected = isFavorite
    }
}
