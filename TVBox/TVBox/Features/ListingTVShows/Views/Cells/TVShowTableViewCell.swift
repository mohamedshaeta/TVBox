//
//  TVShowTableViewCell.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    static let identifier = "TVShowTableViewCell"
    static let nibName = "TVShowTableViewCell"
    
    //MARK: - Outlets
    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowTitleLabel: UILabel!
    @IBOutlet weak var firstAirDateLabel: UILabel!
    @IBOutlet weak var averageVotingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func populateTVShowCard(tvShow: TVShow) {
        if let posterPath = tvShow.posterPath {
            tvShowImageView.downloadImage(from: Keys.ImageBaseUrl + posterPath, completion: nil)
        }
        
        if let title = tvShow.name {
            tvShowTitleLabel.text = title
        }
        
        if let voteAverage = tvShow.voteAverage{
            averageVotingLabel.text = String(voteAverage)
        }
        if let firstAirDate = tvShow.firstAirDate{
            firstAirDateLabel.text = firstAirDate
        }
    }
}
