//
//  PhotoCollectionViewCell.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"
    static let nibName = "PhotoCollectionViewCell"
    @IBOutlet weak private var tvShowPosterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCard(poster : Poster) {
        if let poseterUrl = poster.filePath {
            tvShowPosterImageView.downloadImage(from: Keys.ImageBaseUrl + poseterUrl, completion: nil)
        }
    }

}
