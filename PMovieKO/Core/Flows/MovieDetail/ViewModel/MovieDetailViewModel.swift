final class MovieDetailViewModel {
    weak var navigationDelegate: MovieDetailNavigationDelegate?
    
    let title = "Movie Details"
    
    var movie: Movie
    var callBack: (() -> Void)?
    
    private let favoritesHelper: FavoritesHelping
    
    init(movie: Movie, favoritesHelper: FavoritesHelping) {
        self.movie = movie
        self.favoritesHelper = favoritesHelper
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func onCancelTapped() {
        navigationDelegate?.closeMoveDetail()
    }
    
    func updateFavorite() {
        favoritesHelper.updateFavorites(id: movie.id)
        callBack?()
    }
}
