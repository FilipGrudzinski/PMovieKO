import UIKit

struct AlertBuilder {
    static func buildCommonAlert(dataModel: AlertDataModel) -> UIAlertController {
        let alert = UIAlertController(
            title: dataModel.title,
            message: dataModel.message,
            preferredStyle: dataModel.style.uiStyle)

        dataModel.actions.enumerated().forEach { index, item in
            let action = UIAlertAction(
                title: item.title,
                style: item.style.uiStyle) { _ in
                    item.action?()
                }

            alert.addAction(action)
                if index == .zero {
                    alert.preferredAction = action
                }
        }

        return alert
    }
}
