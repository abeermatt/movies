import Foundation

protocol DataRequester {
    
    typealias DataCallback = (Result<Data>) -> ()
    
    func fetchData(forRequest request: URLRequest, callback: @escaping DataCallback)
    
}

enum DataRequesterError: Error {
    case noData
}
