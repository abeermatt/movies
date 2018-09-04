import UIKit

protocol MovieListDisplayLogic: class {
    func displayMovies(viewModel: MovieList.FetchMovies.ViewModel)
    func displayError(message: String)
}

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    
    fileprivate enum ReuseIdentifiers: String {
        case movieCell
    }
    
    var interactor: MovieListBusinessLogic?
    var router: (NSObjectProtocol & MovieListRoutingLogic & MovieListDataPassing)?
    
    private var movies: [MovieList.FetchMovies.ViewModel.Movie] = [] {
        didSet {
            if oldValue != movies {
                collectionView.reloadData()
            }
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = MovieListAccessibility.view.accessibilityIdentifier
        
        title = "Movies"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: ReuseIdentifiers.movieCell.rawValue)
        collectionView.accessibilityIdentifier = MovieListAccessibility.collectionView.accessibilityIdentifier

        searchBar.delegate = self
        searchBar.placeholder = "Search by title or genre"
        searchBar.accessibilityIdentifier = MovieListAccessibility.searchBar.accessibilityIdentifier
        
        activityIndicator.hidesWhenStopped = true
        
        disableControls()
        
        interactor?.fetchMovies(request: MovieList.FetchMovies.Request(filter: .all))
    }

    func displayMovies(viewModel: MovieList.FetchMovies.ViewModel) {
        enableControls()
        movies = viewModel.movies
    }
    
    func displayError(message: String) {
        enableControls()

        // Realistically we'd do something a lot nicer than this, allowing, or even automatically retrying the failed request
        let alert = UIAlertController(title: "We encountered a problem", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func enableControls() {
        searchBar.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    private func disableControls() {
        searchBar.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }

}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else {
            return
        }
        let model = movies[indexPath.row]
        movieCell.displayModel(model)
    }

}

extension MovieListViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifiers.movieCell.rawValue, for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            interactor?.fetchMovies(request: MovieList.FetchMovies.Request(filter: .all))
            return
        }
        interactor?.fetchMovies(request: MovieList.FetchMovies.Request(filter: .matching(searchText)))
    }
}

extension MovieList.FetchMovies.ViewModel.Movie: MovieCollectionViewCellModel { }
