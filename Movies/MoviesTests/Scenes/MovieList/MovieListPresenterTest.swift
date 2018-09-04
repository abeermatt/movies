import XCTest

class MovieListPresenterTest: XCTestCase {

    private let movieA = Movie(title: "TestMovie_A", posterURL: URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/gri0DDxsERr6B2sOR1fGLxLpSLx.jpg")!, year: 1999, genre: "Action")

    func testDisplaysMovies() {

        let presenter = MovieListPresenter()

        let display = MockMovieDisplay()
        presenter.display = display
        
        presenter.presentMovies(response: .ok([movieA]))
        
        wait(for: [display.displayMoviesInvoked], timeout: 1)
        
        XCTAssertNotNil(display.viewModel)
        
        let movies = display.viewModel!.movies
        XCTAssertEqual(1, movies.count)
        let first = movies.first!
        XCTAssertEqual("TestMovie_A", first.title)
        XCTAssertEqual(URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/gri0DDxsERr6B2sOR1fGLxLpSLx.jpg")!, first.posterURL)
        XCTAssertEqual("1999", first.year)
        XCTAssertEqual("Action", first.genre)
    }
    
    func testDisplaysError() {
        let presenter = MovieListPresenter()
        
        let display = MockMovieDisplay()
        presenter.display = display
        
        presenter.presentMovies(response: .error(MovieSourceError.noData))
        
        wait(for: [display.displayErrorInvoked], timeout: 1)
        
        XCTAssertNotNil(display.errorMessage)
    }
}
