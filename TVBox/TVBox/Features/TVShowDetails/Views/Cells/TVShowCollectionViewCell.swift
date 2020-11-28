//
//  TVShowCollectionViewCell.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class TVShowCollectionViewCell: UICollectionViewCell {

    static let identifier = "TVShowCollectionViewCell"
    static let nibName = "TVShowCollectionViewCell"

    @IBOutlet weak private var tvShowPosterImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCard(tvShow : TVShow) {
        if let photoUrl = tvShow.posterPath {
            tvShowPosterImageView.downloadImage(from: Keys.ImageBaseUrl + photoUrl, completion: nil)
        }
        
        if let title = tvShow.name {
            titleLabel.text = title
        }
    }

}
