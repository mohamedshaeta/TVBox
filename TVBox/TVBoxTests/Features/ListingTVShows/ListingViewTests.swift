//
//  LIstingViewTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class ListingViewTests: XCTestCase {

    func testWhenViewLoaded_instantiatSuccessfuly() {
        //given
        let listingViewController = TVShowsListingViewController.instantiateTVShowsListingViewController()
        
        //when
        
        //then
        XCTAssertNotNil(listingViewController, "Failed to initialize the TVShowsListingViewController.")
    }
    
    func testWhenViewLoaded_PresenterInitialezed() {
        //given
        let listingViewController = TVShowsListingViewController.instantiateTVShowsListingViewController()
        
        //when
        listingViewController.setupPresenter()
        
        //then
        XCTAssertNotNil(listingViewController.tvShowsPresenter, "Failed to initialize the presenter.")
    }
    
    func testWhenViewLoaded_TVShowsTableInitialezed_DelegateAndDataSourceAssigned() {
        //given
        let listingViewController = TVShowsListingViewController.instantiateTVShowsListingViewController()
        
        //when
        _ = listingViewController.view
        
        //then
        XCTAssertNotNil(listingViewController.tvShowsTableView, "Failed to initialize the tvShowsTableView.")
        
        XCTAssertTrue(listingViewController.tvShowsTableView.delegate as! TVShowsListingViewController == listingViewController, "Failed to assign tvshow table delegate.")
        XCTAssertTrue(listingViewController.tvShowsTableView.dataSource as! TVShowsListingViewController == listingViewController, "Failed to assign tvshow table datasource.")
    }

}
