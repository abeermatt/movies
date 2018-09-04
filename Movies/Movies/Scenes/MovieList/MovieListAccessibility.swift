import Foundation

protocol Accessible {
    
    var accessibilityIdentifier: String { get }
}

enum MovieListAccessibility {
    
    case view
    case searchBar
    case collectionView
    
}

extension MovieListAccessibility: Accessible {
    
    var accessibilityIdentifier: String {
        switch self {
        case .view: return "\(type(of: self)).view"
        case .searchBar: return "\(type(of: self)).searchBar"
        case .collectionView: return "\(type(of: self)).collectionView"
        }
    }

}
