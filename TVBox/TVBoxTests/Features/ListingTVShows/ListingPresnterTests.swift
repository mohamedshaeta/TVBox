//
//  ListingPresnterTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class ListingPresnterTests: XCTestCase {
    
    func testWhenInitTVShowsPresenter_TVShowsPresenterInitilized() {
        //given
        let tvshowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        
        //when
        
        
        //then
        XCTAssertNotNil(tvshowsPresenter, "Failed to initialize the tvshowsPresenter.")
    }
    
    func testWhenFetchedTVShowsData_TVListUpdated() {
        //given
        DependencyRegistry.sharedInstance = DependencyRegistryMock()
        let tvshowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        tvshowsPresenter.viewDelegate = TVShowsPresenterViewDelegateMock()
        
        //when
        tvshowsPresenter.fetchTVShows()
        
        //then
        XCTAssertTrue((tvshowsPresenter.viewDelegate as! TVShowsPresenterViewDelegateMock).isTVShowsListUpdated,"Failed to updated list after fetching data")
    }
    
    func testWhenFetchedTVShowsData_InvalidURL_ErrorShown() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let clientManagerMock = ClientManagerMock()
        clientManagerMock.isInvalidURl = true
        dependencyRegistryMock.clientManger = clientManagerMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let tvshowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        tvshowsPresenter.viewDelegate = TVShowsPresenterViewDelegateMock()
        
        //when
        tvshowsPresenter.fetchTVShows()
        
        //then
        XCTAssertFalse((tvshowsPresenter.viewDelegate as! TVShowsPresenterViewDelegateMock).isTVShowsListUpdated,"Update tvshows data even invalid server id")
        XCTAssertTrue((tvshowsPresenter.viewDelegate as! TVShowsPresenterViewDelegateMock).isErrorShown,"Failed to updated list after fetching data")
    }
    
    func testWhenSortTVShows_TVShowsSortedASC() {
        //given
        let tvshowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        tvshowsPresenter.viewDelegate = TVShowsPresenterViewDelegateMock()
        
        //when
       let sortedTVShow = tvshowsPresenter.sortTVShowsByRating(tvShows: getUnSortedTVShows())
        
        //then
        XCTAssertTrue( sortedTVShow[0].voteAverage! >= sortedTVShow[1].voteAverage!,"Failed to updated list after fetching data")
    }
}
extension ListingPresnterTests {
    func getUnSortedTVShows() -> TVShows {
        let tvshow1 = TVShow(voteAverage: 1, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil)
    
        
        let tvshow2 = TVShow(voteAverage: 2, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil)
        
        let tvshow3 = TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil)
        
        let tvshow4 = TVShow(voteAverage: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 1, name: nil, networks: nil, numberOfEpisodes: nil, posterPath: nil, overview: nil, voteCount: nil, images: nil, lastEpisodeToAir: nil)
        
        
        return [tvshow2, tvshow1, tvshow3, tvshow4]
    }
}

fileprivate class DependencyRegistryMock: DependencyRegistry {
    
    var clientManger: ClientManager?
    var tvShowsListingPresenterMock: TVShowsListingPresenterMock?
    
    override func getTVShowsListingPresenter() -> TVShowsListingPresenter {
        return tvShowsListingPresenterMock ?? TVShowsListingPresenterMock()
    }
    
    override func getClientManager() -> ClientManager {
        return clientManger ?? ClientManagerMock()
    }
}

fileprivate class TVShowsListingPresenterMock: TVShowsListingPresenter {
    var presenterViewDelegate: TVShowsPresenterViewDelegateMock?
    override func sortTVShowsByRating(tvShows: TVShows) -> TVShows {
        return tvShows
    }
}

fileprivate class TVShowsPresenterViewDelegateMock: TVShowsListingDelegate {
    var isTVShowsListUpdated = false
    var isErrorShown = false
    func updateTVShows(tvShows: TVShows) {
        isTVShowsListUpdated = true
    }
    
    func showError(with message: String) {
        isErrorShown = true
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

fileprivate class ClientManagerMock: ClientManager {
    var isInvalidURl = false
    override func dataRequest<T: Decodable>(with request: Request, responseObjectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        if isInvalidURl {
            completion(Result.failure(ClientError.invalidURL))
        }else if request.path == TVShowsRequests.fetchTVShows.path {
            completion(Result.success(TVShowsResponse(totalPages: 0, results: nil, totalResults: 0, page: 1) as! T) )
        }
    }
}
