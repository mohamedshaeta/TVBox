//
//  ListViewIntegrationTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/28/20.
//

import Foundation
import XCTest

@testable import TVBox
class TVShowsListingPresenterIntegrationTests: XCTestCase {
    
    func testFetchTVShowsFromServer_TVShowsFetched() {
        //given
        let listingViewPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        let tvShowsListingDelegate = TVShowsListingViewControllerMock()
        var returndTVShows: TVShows?
        listingViewPresenter.viewDelegate = tvShowsListingDelegate
        
        //when
        let exp = expectation(description: "Loading data..")
        tvShowsListingDelegate.tvShowsDidUpdated = { (tvshows) -> Void in
            returndTVShows = tvshows
            exp.fulfill()
        }
        listingViewPresenter.fetchTVShows()
        waitForExpectations(timeout: 3)
        
        //then
        XCTAssertNotNil(returndTVShows, "Failed to fetch tvshows.")
    }
}

class TVShowsListingViewControllerMock: TVShowsListingDelegate {
    var tvShowsDidUpdated: ((TVShows)-> Void)?
    func updateTVShows(tvShows: TVShows) {
            tvShowsDidUpdated?(tvShows)
    }
    
    func showError(with message: String) {}
    func showLoading() {}
    func hideLoading() {}
}

