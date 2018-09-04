import Foundation
import UIKit

extension UIImageView {
    
    func setImage(fromURL url: URL, usingFetcher fetcher: ImageFetcher = DefaultImageFetcher()) {
        fetcher.fetchImage(atURL: url) { [weak self] image in
            guard let `self` = self, let fetchedImage = image else {
                return
            }
            DispatchQueue.main.async {
                self.contentMode = .scaleAspectFill
                self.image = fetchedImage
            }
        }
    }
}

