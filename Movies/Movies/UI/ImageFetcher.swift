import Foundation
import UIKit

// A simple class to fetch and cache images. Realistically, you'd use a third party library that offers more flexibility
protocol ImageFetcher {
    
    typealias ImageCallback = (UIImage?) -> ()
    
    func fetchImage(atURL url: URL, callback: @escaping ImageCallback)
    
}

