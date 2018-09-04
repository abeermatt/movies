import Foundation
import XCTest

class MockMovieDisplay: MovieListDisplayLogic {
    
    var viewModel: MovieList.FetchMovies.ViewModel?
    var errorMessage: String?
    
    let displayMoviesInvoked = XCTestExpectation(description: "display movies invoked")
    let displayErrorInvoked = XCTestExpectation(description: "display movies invoked")

    func displayMovies(viewModel: MovieList.FetchMovies.ViewModel) {
        self.viewModel = viewModel
        self.displayMoviesInvoked.fulfill()
    }
    
    func displayError(message: String) {
        self.errorMessage = message
        self.displayErrorInvoked.fulfill()
    }

}
