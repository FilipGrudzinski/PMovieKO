struct MoviePaginationDTO: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
}
