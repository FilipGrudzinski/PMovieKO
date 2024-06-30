import UIKit

extension UIAlertController {
    func present(on: UIViewController) {
        on.present(self, animated: true)
    }
}
