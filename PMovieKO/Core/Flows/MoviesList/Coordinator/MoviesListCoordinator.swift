
final class MoviesListCoordinator: Coordinator {
    private let navigationController =  CoordinatorNavigationController()
    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private lazy var module = MoviesListViewControllerBuilder.build(navigationDelegate: self)
    
    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    override func start() {
        navigationController.push(module, animated: true) { [weak self] in
            self?.end()
        }
        
        parentCoordinator.showRootViewController(rootViewController: navigationController)
    }
}

extension MoviesListCoordinator: MoviesListNavigationDelegate {
    func showMovieDetails(movie: Movie, callBack: (() -> Void)?) {
        let coordinator = MovieDetailCoordinator(parentNavigation: navigationController, movie: movie, callBack: callBack)
        start(coordinator)
    }
}
