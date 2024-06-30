import XCTest

@testable import PMovieKO

final class AppHTTPClientTests: XCTestCase {
    func test_get_withValidURL_returnsDataAndResponse() async throws {
        let client = MockHTTPClient()
        let expectedData = Data("response data".utf8)
        let expectedResponse = URLResponse(url: URL(string: "https://example.com")!,
                                           mimeType: nil,
                                           expectedContentLength: 0,
                                           textEncodingName: nil)
        client.result = (data: expectedData, response: expectedResponse)
        
        let url = URL(string: "https://example.com")
        let urlParameters = ["param1": "value1"]
        
        let result = try await client.get(url: url, urlParameters: urlParameters)
        
        XCTAssertEqual(result.data, expectedData)
        XCTAssertEqual(result.response.url, expectedResponse.url)
    }
    
    func test_get_withNilURL_throwsBadURLError() async throws {
        let client = AppHTTPClient()
        do {
            _ = try await client.get(url: nil, urlParameters: [:])
            XCTFail("Expected to throw URLError(.badURL)")
        } catch let error as URLError {
            XCTAssertEqual(error, URLError(.badURL))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
        
    func test_get_withServerError_throwsHTTPError() async throws {
        let client = MockHTTPClient()
        client.error = URLError(.badServerResponse)
        
        let url = URL(string: "https://example.com")
        
        do {
            _ = try await client.get(url: url, urlParameters: [:])
            XCTFail("Expected to throw URLError(.badServerResponse)")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
