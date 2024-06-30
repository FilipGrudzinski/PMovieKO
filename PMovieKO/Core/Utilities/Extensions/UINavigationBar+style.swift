import UIKit

extension UINavigationBar {
    func set(style: NavigationBarStyle) {
        DispatchQueue.main.async { [weak self] in
            self?.setup(style: style)
        }
    }
    
    private func setup(style: NavigationBarStyle) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = style.config.barTintColor
        appearance.shadowColor = style.config.shadowColor
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        tintColor = style.config.iconTintColor
        isTranslucent = false
    }
}
