import UIKit

@testable import PMovieKO

final class CoordinatorNavigationControllerSpy: CoordinatorNavigationControllerProtocol {
    var pushCallsCount = 0
    var pushCalled: Bool {
        return pushCallsCount > 0
    }

    var pushReceivedArguments: (
        viewController: UIViewController,
        animated: Bool,
        completion: () -> Void)?
    var pushClosure: ((UIViewController, Bool, @escaping () -> Void) -> Void)?

    func push(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void) {
            pushCallsCount += 1
            pushReceivedArguments = (
                viewController: viewController,
                animated: animated,
                completion: completion)
            pushClosure?(viewController, animated, completion)
        }

    var modalReceivedArguments: (
        viewController: UIViewController,
        animated: Bool,
        completion: () -> Void)?
    var modalCallsCount = 0
    var modalCalled: Bool {
        return modalCallsCount > 0
    }

    var modalClosure: ((UIViewController, Bool, @escaping () -> Void) -> Void)?

    func modal(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void) {
            modalCallsCount += 1
            modalReceivedArguments = (
                viewController: viewController,
                animated: animated,
                completion: completion)
            modalClosure?(viewController, animated, completion)
        }

    var popViewCallsCount = 0
    var popViewCalled: Bool {
        return popViewCallsCount > 0
    }

    var popViewClosure: ((Bool)-> Void)?

    func popView(animated: Bool) {
        popViewCallsCount += 1
        popViewClosure?(animated)
    }

    var popViewReceivedArguments: (
        viewController: UIViewController,
        dismiss: Bool,
        animated: Bool
    )?
    var popViewToCallsCount = 0
    var popViewToCalled: Bool {
        return popViewToCallsCount > 0
    }

    var popViewToClosure: ((UIViewController, Bool, Bool) -> Void)?

    func popViewTo(
        _ viewController: UIViewController,
        dismissTopViewController: Bool,
        animated: Bool) {
            popViewToCallsCount += 1
            popViewReceivedArguments = (
                viewController: viewController,
                dismiss: dismissTopViewController,
                animated: animated
            )
            popViewToClosure?(viewController, dismissTopViewController, animated)
        }

    var dismissViewCallsCount = 0
    var dismissViewCalled: Bool {
        return dismissViewCallsCount > 0
    }

    var dismissViewClosure: (() -> Void)?

    func dismissView(animated: Bool) {
        dismissViewCallsCount += 1
        dismissViewClosure?()
    }
    
    var lockUserInteractionCallsCount = 0
    var lockUserInteractionCalled: Bool {
        return lockUserInteractionCallsCount > 0
    }
    
    var lockUserInteractionClosure: ((Bool) -> Void)?
    
    func lockUserInteraction(isEnabled: Bool) {
        lockUserInteractionCallsCount += 1
        lockUserInteractionClosure?(isEnabled)
    }
}
