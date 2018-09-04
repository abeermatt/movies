import Foundation
import XCTest

struct MovieListScreen {
    
    enum CellCount {
        case atLeast(Int)
        case exactly(Int)
    }
    
    let application: XCUIApplication
    
    var element: XCUIElement {
        return application.descendants(matching: .other).matching(identifier: MovieListAccessibility.view.accessibilityIdentifier).element
    }
    
    var searchBar: XCUIElement {
        return application.descendants(matching: .other).matching(identifier:MovieListAccessibility.searchBar.accessibilityIdentifier).element
    }
    
    var collectionView: XCUIElement {
        return application.collectionViews[MovieListAccessibility.collectionView.accessibilityIdentifier]
    }
    
    func enterIntoSearchBar(_ text: String) {
        searchBar.tap()
        searchBar.typeText(text)
    }
    
    func assertHasMovieCells(_ count: CellCount) {
        let actual = collectionView.cells.count
        switch count {
        case .atLeast(let expected):
            XCTAssertTrue(actual > expected)
        case .exactly(let expected):
            XCTAssertEqual(actual, expected)
        }
    }
    

}

