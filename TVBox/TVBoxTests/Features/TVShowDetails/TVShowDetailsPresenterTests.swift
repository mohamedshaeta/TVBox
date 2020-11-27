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
    
    func testWhenInitTVShowsPresenter_TVShowsPresenterInitilized() {
        //given
        let tvshowsPresenter = DependencyRegistry.sharedInstance.getTVShowsListingPresenter()
        
        //when
        
        
        //then
        XCTAssertNotNil(tvshowsPresenter, "Failed to initialize the tvShowsTableView.")
    }
}
