import Foundation

struct Endpoints {
    private let apiKey = "CREATE OWN OR ASK ME IS NOT SAFE TO KEEP IT ON GIT"
    private let baseURL = "https://api.themoviedb.org/3/"
    
    func nowPlayingMovies() -> URL? {
        createURL("movie/now_playing")
    }
    
    func searchMovies() -> URL? {
        createURL("search/movie")
    }
    
    private func createURL(_ path: String) -> URL? {
        return URL(string: baseURL + path  + "?api_key=\(apiKey)")
    }
}
