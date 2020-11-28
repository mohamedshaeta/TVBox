//
//  TVShowDetailsPresenter.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
protocol TVShowDetailsDelegate: BaseViewDelegate {
    func updateTVShow(tvShow:TVShow)
    func updateTVShowImages(tvShowImages:TVShowImages)
    func updateSimilarTVShow(tvShows: TVShows)
    func didRatedSuccessfuly()
} 

class TVShowDetailsPresenter: BasePresenter {
    
    
    func fetchInitialData(tvShow: TVShow) {
        fetchTVShowDetails(tvShow: tvShow)
        fetchTVShowImages(tvShow: tvShow)
        fetchSimilarTVShows(tvShow: tvShow)
    }
    
    func fetchTVShowDetails(tvShow: TVShow) {
        viewDelegate?.showLoading()
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        clientManager.dataRequest(with: TVShowsRequests.fetchTVShowDetails(tvShowId: tvShow.id), responseObjectType: TVShow.self) { (result) in
            self.viewDelegate?.hideLoading()
            switch result {
            case .success(let response):
                (self.viewDelegate as! TVShowDetailsDelegate).updateTVShow(tvShow: response)
            case .failure(let error):
                self.viewDelegate?.showError(with: error.errorMessage())
            }
        }
    }
    
    func fetchTVShowImages(tvShow: TVShow) {
        viewDelegate?.showLoading()
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        clientManager.dataRequest(with: TVShowsRequests.fetchTVShowImages(tvShowId: tvShow.id), responseObjectType: TVShowImages.self) { (result) in
            self.viewDelegate?.hideLoading()
            switch result {
            case .success(let response):
                (self.viewDelegate as! TVShowDetailsDelegate).updateTVShowImages(tvShowImages: response)
            case .failure(let error):
                self.viewDelegate?.showError(with: error.errorMessage())
            }
        }
    }
    
    func fetchSimilarTVShows(tvShow: TVShow) {
        viewDelegate?.showLoading()
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        clientManager.dataRequest(with: TVShowsRequests.fetchSimilarTVShows(tvShowId: tvShow.id), responseObjectType: TVShowsResponse.self) { (result) in
            self.viewDelegate?.hideLoading()
            switch result {
            case .success(let response):
                if let tvShows = response.results {
                    (self.viewDelegate as! TVShowDetailsDelegate).updateSimilarTVShow(tvShows: tvShows)
                }
            case .failure(let error):
                self.viewDelegate?.showError(with: error.errorMessage())
            }
        }
    }
    
    func rateTVShow(tvShow: TVShow, with value: Double) {
        fetchGuestSessionId { (authenticationResponse) in
            if let guestSessionID = authenticationResponse.guestSessionId {
                let clientManager = DependencyRegistry.sharedInstance.getClientManager()
                clientManager.dataRequest(with: TVShowsRequests.rateTVShow(tvShowId: tvShow.id,value: value, guestSessionId: guestSessionID), responseObjectType: RateResponse.self) { (result) in
                    switch result {
                    case .success(_):
                        (self.viewDelegate as! TVShowDetailsDelegate).didRatedSuccessfuly()
                    case .failure(let error):
                        self.viewDelegate?.showError(with: error.errorMessage())
                    }
                }
            }else {
                self.viewDelegate?.showError(with: ClientError.unauthorized.errorMessage())
            }
        }
    }
    
    func fetchGuestSessionId(completion: @escaping (AuthenticationResponse) -> Void) {
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        clientManager.dataRequest(with: AuthenticationRequests
                                    .fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure:
                completion(AuthenticationResponse(success: false, guestSessionId: nil, expiresAt: nil
                ))
            }
        }
    }
}
