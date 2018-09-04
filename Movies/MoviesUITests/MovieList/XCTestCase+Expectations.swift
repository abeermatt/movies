import Foundation
import XCTest

extension XCTestCase {
    
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 10) {
        let existsPredicate = NSPredicate(format: "exists == 1")
        let existsExpectation = expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        wait(for: [existsExpectation], timeout: timeout)
    }

}

