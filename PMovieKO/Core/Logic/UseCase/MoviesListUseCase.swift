protocol MoviesListUseCase {
    func executeNowPlayingMovies(page: Int) async throws -> MoviePaginationDTO
    func executeSearchMovies(query: String) async throws -> MoviePaginationDTO
}

final class MoviesListUseCaseInteractor: MoviesListUseCase {
    private let repository: MoviesListRepository
    
    init(repository: MoviesListRepository) {
        self.repository = repository
    }
    
    func executeNowPlayingMovies(page: Int) async throws -> MoviePaginationDTO {
        try await repository.fetchNowPlayingMovies(page: page)
    }
    
    func executeSearchMovies(query: String) async throws -> MoviePaginationDTO {
        try await repository.searchMovies(query: query)
    }
}
