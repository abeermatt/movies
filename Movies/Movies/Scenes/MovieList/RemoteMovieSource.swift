import Foundation

class RemoteMovieSource: MovieSource {
    
    private let requester: DataRequester
    
    init(requester: DataRequester = URLSessionDataRequester()) {
        self.requester = requester
    }
    
    func fetchMovies(callback: @escaping MoviesCallback) {

        var request = URLRequest(url: URL(string: "https://movies-sample.herokuapp.com/api/movies")!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        requester.fetchData(forRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                    let movies: [Movie] = response.data.map {
                        return Movie(title: $0.title, posterURL: $0.poster, year: Int($0.year) ?? 0, genre: $0.genre)
                    }
                    callback(.success(movies))
                } catch {
                    callback(.failure(MovieSourceError.unknown(error)))
                }
            case .failure(let error):
                callback(.failure(error))
            }
            
        }
    }
    
}

private struct NetworkMovie: Codable {
    let title: String
    let poster: URL
    let year: String
    let genre: String
}

private struct MovieListResponse: Codable {
    let data: [NetworkMovie]
}

private enum HTTPMethod: String {
    case get
}
