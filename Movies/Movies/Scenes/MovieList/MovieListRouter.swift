import UIKit

protocol MovieListRoutingLogic {
    func routeToMovieDetails()
}

protocol MovieListDataPassing {
    var dataStore: MovieListDataStore? { get }
}

class MovieListRouter: NSObject, MovieListDataPassing {
    weak var viewController: MovieListViewController?
    var dataStore: MovieListDataStore?

}

extension MovieListRouter: MovieListRoutingLogic {
    
    func routeToMovieDetails() {
        // logic to route to movie details.
    }

}
