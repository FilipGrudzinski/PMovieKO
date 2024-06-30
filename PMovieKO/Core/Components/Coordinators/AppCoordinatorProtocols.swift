import UIKit

protocol ApplicationCoordinatorProtocol {
    init(window: UIWindow?)
}

protocol ApplicationParentCoordinatorProtocol {
    func showRootViewController(rootViewController: UIViewController)
    func presentMainView()
}
