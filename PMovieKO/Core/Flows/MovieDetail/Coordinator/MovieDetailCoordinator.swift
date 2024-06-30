final class MovieDetailCoordinator: Coordinator {
    private let parentNavigation: CoordinatorNavigationControllerProtocol
    private let navigationController = CoordinatorNavigationController()
    private let movie: Movie
    private let callBack: (() -> Void)?
    
    private lazy var module = MovieDetailViewControllerBuilder.build(
        movie: movie,
        navigationDelegate: self,
        callBack: callBack)
    
    init(parentNavigation: CoordinatorNavigationControllerProtocol, movie: Movie, callBack: (() -> Void)?) {
        self.parentNavigation = parentNavigation
        self.movie = movie
        self.callBack = callBack
    }
    
    override func start() {
        navigationController.push(module, animated: true) { [weak self] in
            self?.end()
        }
        
        parentNavigation.modal(navigationController, animated: true) { [weak self] in
            self?.end()
        }
    }
}

extension MovieDetailCoordinator: MovieDetailNavigationDelegate {
    func closeMoveDetail() {
        parentNavigation.dismissView(animated: true)
    }
}
