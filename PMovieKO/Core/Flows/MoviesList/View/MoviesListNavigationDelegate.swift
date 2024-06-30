protocol MoviesListNavigationDelegate: AnyObject {
    func showMovieDetails(movie: Movie, callBack: (() -> Void)?)
}
