import Foundation
import UIKit

struct MovieListConfigurator: ControllerConfigurator {
    
    func configure(_ target: MovieListViewController) {
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }
    
}
