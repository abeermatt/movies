import Foundation

class MockDataRequester: DataRequester {
    
    private let result: Result<Data>
    
    init(result: Result<Data>) {
        self.result = result
    }
    
    func fetchData(forRequest request: URLRequest, callback: @escaping DataRequester.DataCallback) {
        callback(result)
    }
    
    
    
}
