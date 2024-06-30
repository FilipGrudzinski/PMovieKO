import Foundation

protocol MovieMapping {
    func map(from: [MovieDTO]) -> [Movie]
}

final class MovieMapper: MovieMapping {
    private struct Constants {
        static let posterBaseURL = "https://image.tmdb.org/t/p/w500/"
    }
    
    private let favoritesHelper: FavoritesHelping
    
    init(favoritesHelper: FavoritesHelping) {
        self.favoritesHelper = favoritesHelper
    }
    
    func map(from: [MovieDTO]) -> [Movie] {
        return from.compactMap { movie in
            var posterLink: URL? = nil
            
            if let posterPath = movie.posterPath {
                let link = Constants.posterBaseURL + posterPath
                posterLink = URL(string: link)
            }
            
            let isFavorite = favoritesHelper.isFavorite(id: movie.id)
            
            return Movie(
                id: movie.id,
                overview: movie.overview,
                title: movie.title,
                voteAverage: movie.voteAverage,
                releaseDate: movie.releaseDate,
                posterLink: posterLink,
                isFavorite: isFavorite)
        }
    }
}
