import XCTest

@testable import PMovieKO

final class MockHTTPClient: HTTPClient {
    var requestedURL: URL?
    var requestedURLParameters: [String: String] = [:]
    var result: HTTPClient.Result?
    var error: Error?
    
    func get(url: URL?, urlParameters: [String: String]) async throws -> HTTPClient.Result {
        self.requestedURL = url
        self.requestedURLParameters = urlParameters
        
        if let error = error {
            throw error
        }
        
        if let result = result {
            return result
        }
        
        throw URLError(.badURL)
    }
}
