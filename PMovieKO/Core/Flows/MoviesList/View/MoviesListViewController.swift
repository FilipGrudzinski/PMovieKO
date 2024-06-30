import UIKit
import Combine

final class MoviesListViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let loadingView = LoadingView(frame: UIScreen.main.bounds)
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private let viewModel: MoviesListViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
   
        bindViewModel()
        viewModel.fetchMovies()
    }
        
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel.title
        
        navigationController?.view.addSubview(loadingView)
        setupSearchController()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.registerCell(MovieTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = viewModel.searchBarPlaceholder
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    private func bindViewModel() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$loader
            .receive(on: RunLoop.main)
            .sink { [weak self] show in
                if show {
                    self?.loadingView.show()
                } else {
                    self?.loadingView.hide()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] model in
                self?.showAlert(model)
            }
            .store(in: &cancellables)
    }
    
    private func showAlert(_ model: AlertDataModel?) {
        guard let model else {
            return
        }
        
        AlertBuilder
            .buildCommonAlert(dataModel: model)
            .present(on: self)
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.fetchMovies()
        refreshControl.endRefreshing()
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.items[indexPath.row]
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setup(title: model.title, isFavorite: model.isFavorite)
        cell.setFavorite = { [weak self] in
            self?.viewModel.setFavorite(id: model.id)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showMovieDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.loadMoreData(index: indexPath.row)
     }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            viewModel.setupItems()
            return
        }
        
        viewModel.searchMovies(query: query)
    }
}
