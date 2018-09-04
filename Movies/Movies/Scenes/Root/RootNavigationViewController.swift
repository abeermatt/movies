import UIKit

class RootNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let controller = topViewController as? MovieListViewController {
            MovieListConfigurator().configure(controller)
        }

    }

}
