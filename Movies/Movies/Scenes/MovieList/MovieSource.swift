import Foundation

struct Movie: Equatable {
    
    let title: String
    let posterURL: URL
    let year: Int
    let genre: String
    
}

protocol MovieSource {
    
    typealias MoviesCallback = (Result<[Movie]>) -> ()
    
    func fetchMovies(callback: @escaping MoviesCallback)
    
}

enum MovieSourceError: Error {
    case noData
    case unknown(Error)
}
