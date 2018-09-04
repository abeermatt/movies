import XCTest

class MovieListUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        application.launch()
    }
    
    func testShowsMovies() {
        let listScreen = MovieListScreen(application: application)
        waitForElement(listScreen.element)
        listScreen.assertHasMovieCells(.atLeast(1))
    }

    func testShowsMoviesMatchingSearchFilter() {
        let listScreen = MovieListScreen(application: application)
        waitForElement(listScreen.element)
        listScreen.enterIntoSearchBar("Action")
        
        // TODO: fragile because dependant on remote api returning exact amount, ideally we'd inject a fixed movie source
        listScreen.assertHasMovieCells(.exactly(6))
        
        listScreen.enterIntoSearchBar("bhjfdsajbfewa")
        listScreen.assertHasMovieCells(.exactly(0))
    }

}
