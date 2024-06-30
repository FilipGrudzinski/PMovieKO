class Coordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parent: CoordinatorProtocol?
    
    deinit {
        print("Deinit \(self)")
    }
    
    func start() { }
    
    func start(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
        coordinator.parent = self
        coordinator.start()
    }
    
    func end() {
        parent?.end(self)
    }
    
    func end(_ coordinator: CoordinatorProtocol) {
        guard let index = childCoordinators
            .firstIndex(where: { $0 === coordinator }) else {
            return
        }
        
        childCoordinators.remove(at: index)
    }
    
    func clearAllChildCoordinators() {
        childCoordinators.forEach {
            $0.childCoordinators.forEach {
                $0.end()
            }
            
            $0.end()
        }
    }
}
