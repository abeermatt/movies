import Foundation

class URLSessionDataRequester: DataRequester {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchData(forRequest request: URLRequest, callback: @escaping (Result<Data>) -> ()) {
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let data = data else {
                callback(.failure(DataRequesterError.noData))
                return
            }
            
            callback(.success(data))
        }
        task.resume()
    }
    
}
