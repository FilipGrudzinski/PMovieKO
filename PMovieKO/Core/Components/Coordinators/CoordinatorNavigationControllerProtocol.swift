import UIKit

protocol CoordinatorNavigationControllerProtocol {
    func push(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    func modal(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)

    func popView(animated: Bool)
    func popViewTo(
        _ viewController: UIViewController,
        dismissTopViewController: Bool,
        animated: Bool)

    func dismissView(animated: Bool)
    
    func lockUserInteraction(isEnabled: Bool)
}
