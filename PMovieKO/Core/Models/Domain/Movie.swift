import Foundation

struct Movie {
    let id: Int
    let overview: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let posterLink: URL?
    var isFavorite: Bool
}
