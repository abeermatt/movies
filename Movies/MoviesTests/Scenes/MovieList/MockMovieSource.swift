import Foundation

class MockMovieSource: MovieSource {
    
    var fetchCallCount = 0
    var result: Result<[Movie]> = .success([])
    
    func fetchMovies(callback: @escaping MovieSource.MoviesCallback) {
        fetchCallCount += 1
        callback(result)
    }
    
}
