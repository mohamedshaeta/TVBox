//
//  SimilerTVShowsCollectionViewDelegate.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
import UIKit
protocol SimilerTVShowsDelegate {
    func didSelectTVShow(tvShow: TVShow)
}

class SimilerTVShowsCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var tvShows: TVShows?
    var delegate: SimilerTVShowsDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tvShow = tvShows?[indexPath.row] {
            delegate?.didSelectTVShow(tvShow: tvShow)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
        
        if let tvShow = tvShows?[indexPath.row] {
            cell.populateCard(tvShow: tvShow)
        }
        return cell
    }
}
