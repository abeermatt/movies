import XCTest
import Movies

class TTLMovieSourceCacheTest: XCTestCase {
    
    private let movieA = Movie(title: "TestMovie_A", posterURL: URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/gri0DDxsERr6B2sOR1fGLxLpSLx.jpg")!, year: 1999, genre: "Action")
    private let movieB = Movie(title: "TestMovie_B", posterURL: URL(string: "https://raw.githubusercontent.com/cesarferreira/sample-data/master/public/posters/038024.jpg")!, year: 2001, genre: "Comedy")
    private let movieC = Movie(title: "TestMovie_C", posterURL: URL(string: "https://raw.githubusercontent.com/cesarferreira/sample-data/master/public/posters/038030.jpg")!, year: 2016, genre: "Romance")

    func testUsesUnderlyingSourceOnInitialFetch() {
        let source = MockMovieSource()
        let cache = TTLMovieSourceCache(source: source)
        
        let expectation = XCTestExpectation(description: "callback is invoked")
        
        cache.fetchMovies { _  in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(1, source.fetchCallCount)
    }
    
    func testReturnsSuccessResultFromSource() {
        let expectedMovies: [Movie] = [movieA, movieC]
        let expectedResult: Result<[Movie]> = .success(expectedMovies)
        let source = MockMovieSource()
        source.result = expectedResult
        
        let cache = TTLMovieSourceCache(source: source)
        
        let expectation = XCTestExpectation(description: "callback is invoked")
        
        cache.fetchMovies { result in
            
            guard case .success(let movies) = result else {
                return
            }
            
            XCTAssertEqual(movies, expectedMovies)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testReturnsFailureResultFromSource() {
        let expectedResult: Result<[Movie]> = .failure(MovieSourceError.noData)
        let source = MockMovieSource()
        source.result = expectedResult
        
        let cache = TTLMovieSourceCache(source: source)
        
        let expectation = XCTestExpectation(description: "callback is invoked")
        
        cache.fetchMovies { result in
            
            guard case .failure(_) = result else {
                return
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    
    func testOnlyUsesSourceWhenWithinTTL() {
        let source = MockMovieSource()
        let clock = SettableClock()
        let cache = TTLMovieSourceCache(source: source, timeToLive: 20, clock: clock)
        
        let expectation = XCTestExpectation(description: "callback is invoked")
        expectation.expectedFulfillmentCount = 5
        
        cache.fetchMovies { result in
            expectation.fulfill()
        }
        cache.fetchMovies { result in
            expectation.fulfill()
        }
        cache.fetchMovies { result in
            expectation.fulfill()
        }
        XCTAssertEqual(1, source.fetchCallCount)
        
        clock.advanceTimeBy(30)
        
        cache.fetchMovies { result in
            expectation.fulfill()
        }
        XCTAssertEqual(2, source.fetchCallCount)
        
        cache.fetchMovies { result in
            expectation.fulfill()
        }
        XCTAssertEqual(2, source.fetchCallCount)

        wait(for: [expectation], timeout: 1)

        
    }
    
    

}
