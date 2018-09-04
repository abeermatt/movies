import Foundation

class TTLMovieSourceCache: MovieSource {
    
    private let source: MovieSource
    private let timeToLive: TimeInterval
    private let clock: Clock
    private var expiry: Date = Date.distantPast
    private var movies: [Movie] = []
    
    init(source: MovieSource, timeToLive: TimeInterval = 10.minutes, clock: Clock = SystemClock()) {
        self.source = source
        self.timeToLive = timeToLive
        self.clock = clock
    }
    
    func fetchMovies(callback: @escaping MovieSource.MoviesCallback) {
        if hasCacheExpired() {
            doFetch(callback: callback)
            return
        }
        callback(.success(movies))
    }
    
    private func hasCacheExpired() -> Bool {
        let now = clock.timeNow()
        return expiry < now
    }
    
    private func doFetch(callback: @escaping MovieSource.MoviesCallback) {
        source.fetchMovies { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.expiry = self.clock.timeNow().addingTimeInterval(self.timeToLive)
                callback(.success(movies))
            case .failure(let error):
                self.movies = []
                self.expiry = Date.distantPast
                callback(.failure(error))
            }
        }
    }
}

private extension Int {
    
    var minutes: TimeInterval {
        return Double(self) * 60.0
    }
    
}
