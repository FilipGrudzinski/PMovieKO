enum AppError: Error, Equatable {
    case serverError
    case general
    case api(ApiError)
}
