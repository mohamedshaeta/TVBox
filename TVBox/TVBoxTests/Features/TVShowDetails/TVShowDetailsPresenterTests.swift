//
//  TVShowDetailsPresenterTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class TVShowDetailsPresenterTests: XCTestCase {
    
    func testWhenInitTVShowDetailsPresenter_TVShowsPresenterInitilized() {
        //given
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        
        //when
        
        
        //then
        XCTAssertNotNil(tvshowDetailsPresenter, "Failed to initialize the tvshowDetailsPresenter.")
    }
    
    func testWhenFetchedTVShowDetails_DetailsPageUpdated() {
        //given
        DependencyRegistry.sharedInstance = DependencyRegistryMock()
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchTVShowDetails(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsUpdated,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowDetails_InvalidURL_ErrorShown() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let clientManagerMock = ClientManagerMock()
        clientManagerMock.isInvalidURl = true
        dependencyRegistryMock.clientManger = clientManagerMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchTVShowDetails(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertFalse((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsUpdated,"Update tvshows data even invalid server id")
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isErrorShown,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowImages_DetailsPageUpdated() {
        //given
        DependencyRegistry.sharedInstance = DependencyRegistryMock()
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchTVShowImages(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsImagesUpdated,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowImages_InvalidURL_ErrorShown() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let clientManagerMock = ClientManagerMock()
        clientManagerMock.isInvalidURl = true
        dependencyRegistryMock.clientManger = clientManagerMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchTVShowImages(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertFalse((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsImagesUpdated,"Update tvshows data even invalid server id")
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isErrorShown,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowSimilar_DetailsPageUpdated() {
        //given
        DependencyRegistry.sharedInstance = DependencyRegistryMock()
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchSimilarTVShows(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsSimilarDataUpdated,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowSimilar_InvalidURL_ErrorShown() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let clientManagerMock = ClientManagerMock()
        clientManagerMock.isInvalidURl = true
        dependencyRegistryMock.clientManger = clientManagerMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.fetchSimilarTVShows(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil))
        
        //then
        XCTAssertFalse((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowDetailsSimilarDataUpdated,"Update tvshows data even invalid server id")
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isErrorShown,"Failed to updated list after fetching data")
    }
    
    func testWhenRateTVShow_DetailsPageUpdated() {
        //given
        DependencyRegistry.sharedInstance = DependencyRegistryMock()
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.rateTVShow(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil),with: 2.0)
        
        //then
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowRatedSuccessfuly,"Failed to updated list after fetching data")
    }
    
    func testWhenRateTVShow_InvalidURL_ErrorShown() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let clientManagerMock = ClientManagerMock()
        clientManagerMock.isInvalidURl = true
        dependencyRegistryMock.clientManger = clientManagerMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let tvshowDetailsPresenter = DependencyRegistry.sharedInstance.getTVShowDetailsPresenter()
        tvshowDetailsPresenter.viewDelegate = TVShowDetailsPresenterViewDelegateMock()
        
        //when
        tvshowDetailsPresenter.rateTVShow(tvShow: TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil),with: 2.0)
        
        //then
        XCTAssertFalse((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isTVShowRatedSuccessfuly,"Update tvshows data even invalid server id")
        XCTAssertTrue((tvshowDetailsPresenter.viewDelegate as! TVShowDetailsPresenterViewDelegateMock).isErrorShown,"Failed to updated list after fetching data")
    }
}
fileprivate class DependencyRegistryMock: DependencyRegistry {
    
    var clientManger: ClientManager?
    var tvShowDetailsPresenterMock: TVShowDetailsPresenter?
    
    override func getTVShowDetailsPresenter() -> TVShowDetailsPresenter {
        return tvShowDetailsPresenterMock ?? TVShowDetailsPresenterMock()
    }
    
    override func getClientManager() -> ClientManager {
        return clientManger ?? ClientManagerMock()
    }
}

fileprivate class TVShowDetailsPresenterMock: TVShowDetailsPresenter {
    var presenterViewDelegate: TVShowDetailsPresenterViewDelegateMock?
}

fileprivate class TVShowDetailsPresenterViewDelegateMock: TVShowDetailsDelegate {
    var isTVShowDetailsUpdated = false
    var isTVShowDetailsImagesUpdated = false
    var isTVShowDetailsSimilarDataUpdated = false
    var isTVShowRatedSuccessfuly = false
    var isErrorShown = false
    
    func updateTVShow(tvShow: TVShow) {
        isTVShowDetailsUpdated = true
    }
    
    func updateTVShowImages(tvShowImages: TVShowImages) {
        isTVShowDetailsImagesUpdated = true
    }
    
    func updateSimilarTVShow(tvShows: TVShows) {
        isTVShowDetailsSimilarDataUpdated = true
    }
    
    func didRatedSuccessfuly() {
        isTVShowRatedSuccessfuly = true
    }
    
    func showError(with message: String) {
        isErrorShown = true
    }
    
    func showLoading() {}
    
    func hideLoading() {}
}

fileprivate class ClientManagerMock: ClientManager {
    var isInvalidURl = false
    override func dataRequest<T: Decodable>(with request: Request, responseObjectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        if isInvalidURl {
            completion(Result.failure(ClientError.invalidURL))
        }else if request.path == TVShowsRequests.fetchTVShowDetails(tvShowId: 1).path {
            completion(Result.success(TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil) as! T) )
        }else if request.path == TVShowsRequests.fetchTVShowImages(tvShowId: 1).path {
            completion(Result.success(TVShowImages(id: 1, posters: nil, backdrops: nil) as! T))
        }else if request.path == TVShowsRequests.fetchSimilarTVShows(tvShowId: 1).path {
            completion(Result.success(TVShowsResponse(totalPages: 0, results: [], totalResults: 0, page: 1) as! T) )
        }else if request.path == TVShowsRequests.rateTVShow(tvShowId: 1, value: 2.0, guestSessionId: "").path {
            completion(Result.success(RateResponse(statusCode: 1, statusMessage: "Success") as! T) )
        }else if request.path == AuthenticationRequests.fetchGuestSessionId.path {
            completion(Result.success(AuthenticationResponse(success: true, guestSessionId: "", expiresAt: nil) as! T) )
        }
    }
}
