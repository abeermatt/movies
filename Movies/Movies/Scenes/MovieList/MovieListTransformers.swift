import Foundation

extension MovieList.FetchMovies {
    
    struct MovieTransformer {
        
        func transformToViewModel(movie: Movie) -> MovieList.FetchMovies.ViewModel.Movie {
            return MovieList.FetchMovies.ViewModel.Movie(year: "\(movie.year)", title: movie.title, posterURL: movie.posterURL, genre: movie.genre)
        }

    }
    
}
