import UIKit

final class MovieDetailViewControllerBuilder {
    static func build(movie: Movie, navigationDelegate: MovieDetailNavigationDelegate, callBack: (() -> Void)?) -> UIViewController {
        let defaults: UserDefaultsHelping = UserDefaultsHelper()
        let favoritesHelper: FavoritesHelping = FavoritesHelper(defaults: defaults)
        let viewModel = MovieDetailViewModel(movie: movie, favoritesHelper: favoritesHelper)
        viewModel.navigationDelegate = navigationDelegate
        viewModel.callBack = callBack
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
