import UIKit

final class CoordinatorNavigationController: BaseNavigationController {
    private var controllersCompletions: [UIViewController: () -> Void] = [:]

    var modalClosure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    private func removesUselessReferencesOnStack(_ viewControllers: [UIViewController]) {
        let viewControllersToRemove = controllersCompletions.filter { !viewControllers.contains($0.key) }.keys

        viewControllersToRemove.forEach {
            callCoordinatorEndClosure(viewController: $0)
        }
    }

    private func callCoordinatorEndClosure(viewController: UIViewController) {
        controllersCompletions[viewController]?()
        controllersCompletions.removeValue(forKey: viewController)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isBeingDismissed {
            modalClosure?()
        }
    }

    deinit {
        print("Deinit \(self)")
    }
}

extension CoordinatorNavigationController: CoordinatorNavigationControllerProtocol {
    func popView(animated: Bool) {
        popViewController(animated: animated)
    }
    
    func lockUserInteraction(isEnabled: Bool) {
        navigationBar.isUserInteractionEnabled = isEnabled
        interactivePopGestureRecognizer?.isEnabled = isEnabled
    }

    func popViewTo(
        _ viewController: UIViewController,
        dismissTopViewController: Bool,
        animated: Bool) {
            if dismissTopViewController {
                dismissView()
            }

            let viewControllersBefore = viewControllers
            popToViewController(viewController, animated: animated)
            let poppedViewControllers = viewControllersBefore.difference(
                from: viewControllers)

            popToViewController(viewController, animated: animated)

            poppedViewControllers.forEach {
                callCoordinatorEndClosure(viewController: $0)
            }
        }

    func push(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void) {
            pushViewController(viewController, animated: animated)
            controllersCompletions[viewController] = completion
        }

    func modal(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void) {
            present(viewController, animated: animated)
            modalClosure = completion
        }

    func dismissView(animated: Bool = true) {
        dismiss(animated: animated)
        modalClosure?()
        modalClosure = nil
    }
}

extension CoordinatorNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {
            guard let poppedViewController = navigationController
                .transitionCoordinator?.viewController(forKey: .from),
                  !navigationController.viewControllers
                .contains(poppedViewController)
            else {
                return
            }

            removesUselessReferencesOnStack(viewControllers)
        }
}
