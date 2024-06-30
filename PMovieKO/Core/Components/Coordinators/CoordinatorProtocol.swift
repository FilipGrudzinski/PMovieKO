protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var parent: CoordinatorProtocol? { get set }
    func start()
    func start(_ coordinator: CoordinatorProtocol)
    func end()
    func end(_ coordinator: CoordinatorProtocol)
    func clearAllChildCoordinators()
}
