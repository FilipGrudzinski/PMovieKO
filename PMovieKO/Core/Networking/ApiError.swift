struct ApiError: Codable, Equatable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
}
