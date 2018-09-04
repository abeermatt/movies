import Foundation

struct SystemClock: Clock {
    
    func timeNow() -> Date {
        return Date()
    }
}


