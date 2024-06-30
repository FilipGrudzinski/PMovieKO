import Foundation

final class MoviesListDataSource: MoviesListRepository {
    private let httpClinet: HTTPClient
    private let endpoints: Endpoints
    private let decoder: JSONDecoder
    
    init(httpClinet: HTTPClient, endpints: Endpoints, decoder: JSONDecoder) {
        self.httpClinet = httpClinet
        self.endpoints = endpints
        self.decoder = decoder
    }
        
    func fetchNowPlayingMovies(page: Int) async throws -> MoviePaginationDTO {
        let url = endpoints.nowPlayingMovies()
                
        do {
            let urlParameters = ["page": "\(page)"]
            let result = try await httpClinet.get(url: url, urlParameters: urlParameters)
            
            if let error = ErrorParser.parseError(result: result) {
                throw error
            }
            
            guard let model = try? decoder.decode(MoviePaginationDTO.self, from: result.data) else {
                throw AppError.general
            }
            
            return model
        } catch {
            throw error
        }
    }
 
    func searchMovies(query: String) async throws -> MoviePaginationDTO {
        let url = endpoints.searchMovies()
        
        do {
            let urlParameters = ["query": query]
            let result = try await httpClinet.get(url: url, urlParameters: urlParameters)
            
            if let error = ErrorParser.parseError(result: result) {
                throw error
            }
            
            guard let model = try? decoder.decode(MoviePaginationDTO.self, from: result.data) else {
                throw AppError.general
            }
            
            return model
        } catch {
            throw error
        }
    }
}
