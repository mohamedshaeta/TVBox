//
//  DependencyRegistry.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
class DependencyRegistry {
    
    static var sharedInstance: DependencyRegistry = DependencyRegistry()
    
    // MARK: - Presenters
    func getTVShowsListingPresenter() -> TVShowsListingPresenter {
        return TVShowsListingPresenter()
    }
    
    func getTVShowDetailsPresenter() -> TVShowDetailsPresenter {
        return TVShowDetailsPresenter()
    }

    // MARK: - Network
    func getClientManager() -> ClientManager {
        return ClientManager()
    }
    
    func getURLSession() -> URLSession {
        return URLSession.shared
    }
}


