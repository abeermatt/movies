import Foundation
import UIKit

struct DefaultImageFetcher: ImageFetcher {
    
    private let session: URLSession
    private let cache: URLCache

    init(session: URLSession = URLSession.shared, cache: URLCache = URLCache.shared) {
        self.session = session
        self.cache = cache
    }
    
    func fetchImage(atURL url: URL, callback: @escaping ImageCallback) {
        
        func onImageData(_ data: Data) {
            let image = UIImage(data: data)
            callback(image)
        }
        
        let request = URLRequest(url: url)
        if let cached = cache.cachedResponse(for: request) {
            onImageData(cached.data)
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            guard let imageData = data, let urlResponse = response else {
                return
            }
            onImageData(imageData)
            
            let cachedResponse = CachedURLResponse(response: urlResponse, data: imageData)
            self.cache.storeCachedResponse(cachedResponse, for: request)
        }
        
        task.resume()
    }
    
}
