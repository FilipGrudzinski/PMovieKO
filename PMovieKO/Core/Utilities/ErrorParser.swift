import Foundation

final class ErrorParser {
    static func parseError(result: HTTPClient.Result) -> AppError? {
        if let response = result.response as? HTTPURLResponse,
           500...599 ~= response.statusCode {
            return AppError.serverError
        } else {
            return parseAPIError(data: result.data)
        }
    }
    
    static func parseAPIError(data: Data) -> AppError? {
        let decoder = APIDecoder.get()
        
        guard let error = try? decoder.decode(ApiError.self, from: data) else {
            return nil
        }
        
        return .api(error)
    }
}
