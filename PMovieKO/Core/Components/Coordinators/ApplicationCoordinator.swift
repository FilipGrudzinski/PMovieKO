import UIKit

final class ApplicationCoordinator: Coordinator, ApplicationCoordinatorProtocol {
    private weak var window: UIWindow?
    
    required init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        presentMainView()
    }
    
}

extension ApplicationCoordinator: ApplicationParentCoordinatorProtocol {
    func showRootViewController(rootViewController: UIViewController) {
        window?.rootViewController = rootViewController
    }
    
    func presentMainView() {
        clearAllChildCoordinators()
        
        let coordinator = MoviesListCoordinator(parentCoordinator: self)
        start(coordinator)
    }
}

