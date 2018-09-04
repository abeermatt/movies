import Foundation
import UIKit

protocol ControllerConfigurator {
    associatedtype ControllerType: UIViewController
    
    func configure(_ target: ControllerType)
    
}

