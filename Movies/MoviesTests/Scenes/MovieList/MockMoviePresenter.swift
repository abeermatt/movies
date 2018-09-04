import Foundation
import XCTest

class MockMoviePresenter: MovieListPresentationLogic {
    
    var presentMoviesInvoked = XCTestExpectation(description: "present invoked")
    var movies: [Movie]?
    var error: MovieList.FetchMovies.FetchError?
    
    func presentMovies(response: MovieList.FetchMovies.Response) {
        switch response {
        case .ok(let movies): self.movies = movies
        case .error(let error): self.error = error
        }
        presentMoviesInvoked.fulfill()
    }
    
    
}
