import UIKit

protocol MovieListBusinessLogic {
    func fetchMovies(request: MovieList.FetchMovies.Request)
}

protocol MovieListDataStore {
}

class MovieListInteractor: MovieListDataStore, MovieListBusinessLogic {
    var presenter: MovieListPresentationLogic?
    var source: MovieSource = TTLMovieSourceCache(source: RemoteMovieSource())
    
    func fetchMovies(request: MovieList.FetchMovies.Request) {
        // Filtering is done here because we know the api doesn't support it.
        source.fetchMovies { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let movies):
                let filtered = request.filter.filterMovies(movies)
                self.presenter?.presentMovies(response: .ok(filtered))
            case .failure(let error):
                self.presenter?.presentMovies(response: .error(error))
            }
        }
    }
    
}

private extension MovieList.FetchMovies.Request.Filter {
    
    func filterMovies(_ movies: [Movie]) -> [Movie] {
        switch self {
        case .all:
            return movies
        case .matching(let text):
            return movies.filter { movie in
                return movie.title.contains(text) || movie.genre.contains(text)
            }
        }
    }
    
}

