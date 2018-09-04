import Foundation

class SettableClock: Clock {
    
    var time = Date()
    
    func timeNow() -> Date {
        return time
    }
    
    func advanceTimeBy(_ interval: TimeInterval) {
        time = time.addingTimeInterval(interval)
    }
    
}
