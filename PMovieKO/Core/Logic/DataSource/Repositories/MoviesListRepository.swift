protocol MoviesListRepository {
    func fetchNowPlayingMovies(page: Int) async throws -> MoviePaginationDTO
    func searchMovies(query: String) async throws -> MoviePaginationDTO
}
