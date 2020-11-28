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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCard(tvShow : TVShow) {
        if let photoUrl = tvShow.posterPath {
            tvShowPosterImageView.downloadImage(from: Keys.ImageBaseUrl + photoUrl, completion: nil)
        }
    }

}
