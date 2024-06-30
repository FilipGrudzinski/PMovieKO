import UIKit

struct MoviesListViewControllerBuilder {
    static func build(navigationDelegate: MoviesListNavigationDelegate) -> UIViewController {
        let defaults: UserDefaultsHelping = UserDefaultsHelper()
        let favoritesHelper: FavoritesHelping = FavoritesHelper(defaults: defaults)
        let mapper: MovieMapping = MovieMapper(favoritesHelper: favoritesHelper)
        let movieListRepository: MoviesListRepository = MoviesListRepositoryBuilder.build()
        let movieListUseCase: MoviesListUseCase = MoviesListUseCaseInteractor(repository: movieListRepository)
        let viewModel = MoviesListViewModel(
            moviesListUseCase: movieListUseCase,
            favoritesHelper: favoritesHelper,
            mapper: mapper)
        viewModel.navigationDelegate = navigationDelegate
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        return viewController
    }
}
