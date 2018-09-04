import UIKit

protocol MovieListPresentationLogic {
    func presentMovies(response: MovieList.FetchMovies.Response)
}

class MovieListPresenter: MovieListPresentationLogic {
    weak var display: MovieListDisplayLogic?

    fileprivate let transformer = MovieList.FetchMovies.MovieTransformer()
    
    func presentMovies(response: MovieList.FetchMovies.Response) {
        switch response {
        case .ok(let movies):
            let transformed = movies.map { transformer.transformToViewModel(movie: $0) }
            let viewModel = MovieList.FetchMovies.ViewModel(movies: transformed)
            DispatchQueue.main.async {
                self.display?.displayMovies(viewModel: viewModel)
            }
        case .error(_):
            DispatchQueue.main.async {
                self.display?.displayError(message: "Ooops, something went wrong")
            }
        }
    }

}

 
