//
//  File.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
import UIKit

class PhotosCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var tvShowImages: TVShowImages?
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            return CGSize(width: width, height: collectionView.bounds.height)
        }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tvShowImages?.backdrops?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            
            if let poster = tvShowImages?.backdrops?[indexPath.row] {
                cell.populateCard(poster: poster)
            }
            return cell
        }
}
    

