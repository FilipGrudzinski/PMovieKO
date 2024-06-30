import UIKit

final class AlertDataModel {
    enum CommonAlertStyle {
        case alert
        case sheet

        var uiStyle: UIAlertController.Style {
            switch self {
            case .alert:
                    .alert
            case .sheet:
                    .actionSheet
            }
        }
    }

    var style: CommonAlertStyle = .alert
    var actions: [CommonAlertAction]

    let title: String?
    let message: String?

    init(title: String?,
         message: String?,
         style: CommonAlertStyle = .alert,
         actions: [CommonAlertAction]) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
    }
}
