import UIKit

enum NavigationBarStyle {
    case primary
    
    var config: NavigationBarConfig {
        switch self {
        case .primary:
            return PrimaryNavigationBarConfig()
        }
    }
}

protocol NavigationBarConfig {
    var barTintColor: UIColor { get }
    var iconTintColor: UIColor { get }
    var titleColor: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var shadowColor: UIColor { get }
}

struct PrimaryNavigationBarConfig: NavigationBarConfig {
    let barTintColor: UIColor = .white
    let iconTintColor: UIColor = .tintColor
    let titleColor: UIColor = .darkText
    let statusBarStyle: UIStatusBarStyle = .darkContent
    let shadowColor: UIColor = .separator
}
