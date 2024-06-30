import UIKit

struct CommonAlertAction {
    enum CommonAlertButtonStyle {
        case cancel
        case destructive
        case `default`

        var uiStyle: UIAlertAction.Style {
            switch self {
            case .cancel:
                    .cancel
            case .destructive:
                    .destructive
            case .default:
                    .default
            }
        }
    }

    let title: String
    var style: CommonAlertButtonStyle = .default
    var action: (() -> Void)?
}
