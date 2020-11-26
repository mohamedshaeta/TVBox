//
//  TVShowsListingPresenter.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
protocol TVShowsListingPresenterDelegate: BaseViewDelegate {
    func updateTVShows(tvShows: TVShows)
}

class TVShowsListingPresenter: BasePresenter {
    func fetchTVShows() {
        viewDelegate?.showLoading()
        let clientManager = DependencyRegistry.sharedInstance.getCLientManager()
        clientManager.dataRequest(with: TVShowsRequests.tvShows, responseObjectType: TVShowsResponse.self) { (result) in
            self.viewDelegate?.hideLoading()
            switch result {
            case .success(let response):
                let sortedTVShows = self.sortTVShowsByRating(tvShows: response.results ?? [])
                (self.viewDelegate as! TVShowsListingPresenterDelegate).updateTVShows(tvShows: sortedTVShows)
            case .failure(let error):
                self.viewDelegate?.showError(with: error.errorMessage())
            }
        }
    }
    
    func sortTVShowsByRating(tvShows: TVShows) -> TVShows {
        let sortedTVShows = tvShows.sorted(by: { (tvShow1
                                                      , tvShow2) -> Bool in
            tvShow1.voteAverage ?? 0 > tvShow2.voteAverage ?? 0
        })
        return sortedTVShows
    }
}