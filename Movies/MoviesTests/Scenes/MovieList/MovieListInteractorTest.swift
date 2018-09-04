import XCTest

class MovieListInteractorTest: XCTestCase {
    
    private let movieA = Movie(title: "TestMovie_A", posterURL: URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/gri0DDxsERr6B2sOR1fGLxLpSLx.jpg")!, year: 1999, genre: "Action")
    private let movieB = Movie(title: "TestMovie_B", posterURL: URL(string: "https://raw.githubusercontent.com/mashbytes/smdb/master/Web/thumbnails/038024.jpg")!, year: 2001, genre: "Comedy")
    private let movieC = Movie(title: "TestMovie_C", posterURL: URL(string: "https://raw.githubusercontent.com/mashbytes/smdb/master/Web/thumbnails/038030.jpg")!, year: 2016, genre: "Romance")

    
    func testUsesSourceToFetchMovies() {
        let source = MockMovieSource()
        source.result = .success([movieA, movieC])
        
        let interactor = MovieListInteractor()
        interactor.source = source
        
        interactor.fetchMovies(request: MovieList.FetchMovies.Request(filter: .all))
        
        XCTAssertEqual(1, source.fetchCallCount)
    }
    
    func testPresentsFetchedMoviesFromSource() {
        let source = MockMovieSource()
        let movies = [movieA, movieC]
        source.result = .success(movies)

        let interactor = MovieListInteractor()
        interactor.source = source
        
        let presenter = MockMoviePresenter()
        interactor.presenter = presenter

        interactor.fetchMovies(request: MovieList.FetchMovies.Request(filter: .all))
        
        wait(for: [presenter.presentMoviesInvoked], timeout: 1)
        
        XCTAssertEqual(presenter.movies, movies)
    }
    
    func testPresentedFetchErrorFromSource() {
        let source = MockMovieSource()
        source.result = .failure(MovieSourceError.noData)
        
        let interactor = MovieListInteractor()
        interactor.source = source
        
        let presenter = MockMoviePresenter()
        interactor.presenter = presenter
        
        interactor.fetchMovies(request: MovieList.FetchMovies.Request(filter: .all))
        
        wait(for: [presenter.presentMoviesInvoked], timeout: 1)
        
        XCTAssertNotNil(presenter.error)
    }
    
    func testAdheresToFetchRequestFilter() {
        let source = MockMovieSource()
        let movies = [movieA, movieB, movieC]
        source.result = .success(movies)
        
        let interactor = MovieListInteractor()
        interactor.source = source
        
        let presenter = MockMoviePresenter()
        interactor.presenter = presenter
        
        interactor.fetchMovies(request: MovieList.FetchMovies.Request(filter: .matching("Action")))
        
        wait(for: [presenter.presentMoviesInvoked], timeout: 1)
        
        XCTAssertEqual(presenter.movies, [movieA])

    }
}
