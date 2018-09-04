import UIKit

enum MovieList {

    enum FetchMovies {
        
        typealias FetchError = Error
        
        struct Request {
            let filter: Filter
            
            enum Filter {
                case all
                case matching(String)
            }
        }
        
        enum Response {
            case ok([Movie])
            case error(FetchError)
        }
        
        struct ViewModel {
            
            let movies: [Movie]
            
            struct Movie: Equatable {
                let year: String
                let title: String
                let posterURL: URL
                let genre: String
            }
        }
    }
    
}
