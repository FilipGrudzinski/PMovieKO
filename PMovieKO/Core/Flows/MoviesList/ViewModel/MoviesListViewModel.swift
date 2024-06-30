import Foundation
import Combine

final class MoviesListViewModel {
    weak var navigationDelegate: MoviesListNavigationDelegate?
    
    @Published var items: [Movie] = []
    @Published var loader: Bool = false
    @Published var search = ""
    @Published var error: AlertDataModel?
    
    let title = "Now Playing"
    let searchBarPlaceholder = "Search movies..."
    
    private let moviesListUseCase: MoviesListUseCase
    private let favoritesHelper: FavoritesHelping
    private let mapper: MovieMapping
    
    private var cancellables: Set<AnyCancellable> = []
    private var rawData: [MovieDTO] = []
    private var page: Int = 1
    private var maxPages: Int = .zero
    
    init(moviesListUseCase: MoviesListUseCase, favoritesHelper: FavoritesHelping, mapper: MovieMapping) {
        self.moviesListUseCase = moviesListUseCase
        self.favoritesHelper = favoritesHelper
        self.mapper = mapper
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? AppError {
            switch error {
            case .serverError, .general:
                self.error = createCommonAlertModel()
            case let .api(error):
                self.error = createApiAlertModel(error)
            }
        }
    }
    
    private func createCommonAlertModel() -> AlertDataModel {
        let action = CommonAlertAction(title: "OK")
        return AlertDataModel(title: "Ups", message: "Coś poszło nie tak", actions: [action])
    }
    
    private func createApiAlertModel(_ error: ApiError) -> AlertDataModel {
        let action = CommonAlertAction(title: "Retry") { [weak self] in
            self?.fetchMovies()
        }
        
        return AlertDataModel(title: "\(error.statusCode)", message: error.statusMessage, actions: [action])
    }
}

extension MoviesListViewModel {
    func loadMoreData(index: Int) {
        let lastElement = items.count - 1
        
        guard index == lastElement, page < maxPages else {
            return
        }
        let newPage = page + 1
        fetchMovies(page: newPage)
    }
    
    func fetchMovies(page: Int = 1) {
        loader = true
        
        Task {
            do {
                let model = try await moviesListUseCase.executeNowPlayingMovies(page: page)
                rawData += model.results
                maxPages = model.totalPages
                self.page = model.page
                setupItems()
            } catch {
                handleError(error)
            }
            
            loader = false
        }
    }
    
    func searchMovies(query: String) {
        loader = true
        
        Task {
            do {
                let model = try await moviesListUseCase.executeSearchMovies(query: query)
                items = mapper.map(from: model.results)
            } catch {
                self.error = createCommonAlertModel()
            }
            
            loader = false
        }
    }
    
    func showMovieDetails(index: Int) {
        guard let movie = items[safeIndex: index] else {
            return
        }
        
        navigationDelegate?.showMovieDetails(movie: movie) { [weak self] in
            self?.setupItems()
        }
    }
    
    func setFavorite(id: Int) {
        var tempItems = items
        if let index = tempItems.firstIndex(where: { $0.id == id }) {
            var item = tempItems.remove(at: index)
            item.isFavorite.toggle()
            tempItems.insert(item, at: index)
            self.items = tempItems
        }
        favoritesHelper.updateFavorites(id: id)
    }
    
    func setupItems() {
        items = mapper.map(from: rawData)
    }
}
