import UIKit

final class LoadingView: UIView {
    private struct Constants {
        static let backgroundAlpha: CGFloat = 0.2
    }
    private var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white.withAlphaComponent(Constants.backgroundAlpha)

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func show() {
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
