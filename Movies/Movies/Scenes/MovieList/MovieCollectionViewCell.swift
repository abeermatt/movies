import Foundation
import UIKit

protocol MovieCollectionViewCellModel {
    var title: String { get }
    var genre: String { get }
    var posterURL: URL { get }
    var year: String { get }
    
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil)
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreLabelBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.alpha = 0.8
        genreLabelBackground.layer.cornerRadius = genreLabelBackground.frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        genreLabel.text = nil
        posterImageView.image = nil
        posterImageView.contentMode = .center
        posterImageView.image = UIImage(named: "clapboard")
    }
    
    func displayModel(_ model: MovieCollectionViewCellModel) {
        titleLabel.text = model.title
        genreLabel.text = model.genre
        posterImageView.setImage(fromURL: model.posterURL)
    }
}

