import Foundation

protocol HTTPClient {
    typealias Result = (data: Data, response: URLResponse)
    
    func get(url: URL?, urlParameters: [String: String]) async throws -> Result
}

final class AppHTTPClient: HTTPClient {
    func get(
        url: URL?,
        urlParameters: [String: String] = [:]) async throws -> HTTPClient.Result {
            guard let url else {
                throw URLError(.badURL)
            }
            
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            urlParameters.forEach {
                urlComponents?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
            }

            guard let resolvedURL = urlComponents?.url else {
                throw URLError(.badURL)
            }
                        
            var request = URLRequest(url: resolvedURL)
            request.httpMethod = HTTPMethod.GET.rawValue
            
            let response = try await URLSession.shared.data(for: request)
            
            return response
        }
}
