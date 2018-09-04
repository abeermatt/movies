import XCTest

class RemoveMovieSourceTest: XCTestCase {
    

    func testCallsFailureWhenNoData() {
        let dataResult: Result<Data> = .failure(DataRequesterError.noData)
        let mockRequester = MockDataRequester(result: dataResult)
        
        let movieSource = RemoteMovieSource(requester: mockRequester)
        
        let expectation = XCTestExpectation(description: "callback invoked")
        movieSource.fetchMovies { result in

            guard case .failure(DataRequesterError.noData) = result else {
                return
            }

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCallsFailureWhenBadlyFormattedJSON() {
        let data = "{\"data\":{\"i am a mistake\": \"true\"}".data(using: .utf8)!
        let dataResult: Result<Data> = .success(data)
        let mockRequester = MockDataRequester(result: dataResult)
        
        let movieSource = RemoteMovieSource(requester: mockRequester)
        
        let expectation = XCTestExpectation(description: "callback invoked")
        movieSource.fetchMovies { result in
            
            guard case .failure(_) = result else {
                return
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)

    }
    
    func testCallsSuccessWithMovies() {
        let data = "{\"data\":[{\"id\":912312,\"title\":\"Dunkirk\",\"year\":\"2017\",\"genre\":\"History\",\"poster\":\"https://goo.gl/1zUyyq\"},{\"id\":11241,\"title\":\"Jumanji: welcome to the jungle\",\"year\":\"2017\",\"genre\":\"Action\",\"poster\":\"https://image.tmdb.org/t/p/w370_and_h556_bestv2/bXrZ5iHBEjH7WMidbUDQ0U2xbmr.jpg\"}]}".data(using: .utf8)!
        let dataResult: Result<Data> = .success(data)
        let mockRequester = MockDataRequester(result: dataResult)
        
        let movieSource = RemoteMovieSource(requester: mockRequester)
        
        let expectation = XCTestExpectation(description: "callback invoked")
        movieSource.fetchMovies { result in
            
            guard case .success(let movies) = result else {
                return
            }
            XCTAssertEqual(2, movies.count)
            XCTAssertEqual(movies[0], Movie(title: "Dunkirk", posterURL: URL(string: "https://goo.gl/1zUyyq")!, year: 2017, genre: "History"))
            XCTAssertEqual(movies[1], Movie(title: "Jumanji: welcome to the jungle", posterURL: URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/bXrZ5iHBEjH7WMidbUDQ0U2xbmr.jpg")!, year: 2017, genre: "Action"))

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)

    }
    
}
