struct MoviesListRepositoryBuilder {
    static func build() -> MoviesListRepository {
        let httpClinet: HTTPClient = AppHTTPClient()
        let endpoints = Endpoints()
        let decoder = APIDecoder.get()
        let repository = MoviesListDataSource(httpClinet: httpClinet, endpints: endpoints, decoder: decoder)
        
        return repository
    }
}
