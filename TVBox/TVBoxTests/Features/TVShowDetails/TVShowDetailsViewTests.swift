//
//  TVShowDetailsViewTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class TVShowDetailsViewTests: XCTestCase {

    func testWhenViewLoaded_instantiatSuccessfuly() {
        //given
        let tvShowdetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        
        //when
        
        //then
        XCTAssertNotNil(tvShowdetailsView, "Failed to initialize the TVShowsListingViewController.")
    }
    
    func testWhenViewLoaded_PresenterInitialezed() {
        //given
        let tvShowdetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        
        //when
        tvShowdetailsView.setupPresenter()
        
        //then
        XCTAssertNotNil(tvShowdetailsView.tvShowDetailsPresenter, "Failed to initialize the presenter.")
    }
    
    func testWhenViewLoaded_PhotosCollectionInitialezed_DelegateAndDataSourceAssigned() {
        //given
        let tvShowdetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        
        //when
        let _ = tvShowdetailsView.view
        
        //then
        XCTAssertNotNil(tvShowdetailsView.postersCollectionView, "Failed to initialize the tvShowsTableView.")
        
        XCTAssertTrue(tvShowdetailsView.postersCollectionView.delegate as? PhotosCollectionViewDelegate == tvShowdetailsView.photosCollectionViewDelegate, "Failed to assign postersCollectionView delegate.")
        XCTAssertTrue(tvShowdetailsView.postersCollectionView.dataSource as? PhotosCollectionViewDelegate == tvShowdetailsView.photosCollectionViewDelegate, "Failed to assign postersCollectionView datasource.")
    }
    
    func testWhenViewLoaded_SimilarCollectionInitialezed_DelegateAndDataSourceAssigned() {
        //given
        let tvShowdetailsView = TVShowDetailsViewController.instantiateTVShowDetailsViewController()
        
        //when
        let _ = tvShowdetailsView.view
        
        //then
        XCTAssertNotNil(tvShowdetailsView.similarTVShowsCollectionView, "Failed to initialize the similarTVShowsCollectionView.")
        
        XCTAssertTrue(tvShowdetailsView.similarTVShowsCollectionView.delegate as? SimilerTVShowsCollectionViewDelegate == tvShowdetailsView.similerTVShowsCollectionViewDelegate, "Failed to assign tvshow table delegate.")
        XCTAssertTrue(tvShowdetailsView.similarTVShowsCollectionView.dataSource as? SimilerTVShowsCollectionViewDelegate == tvShowdetailsView.similerTVShowsCollectionViewDelegate, "Failed to assign tvshow table datasource.")
    }

}
