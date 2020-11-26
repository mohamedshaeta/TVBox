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

    // MARK: - Network
    func getCLientManager() -> ClientManager {
        return ClientManager()
    }
    
    func getURLSession() -> URLSession {
        return URLSession.shared
    }
    
    // MARK: - UserDefaultsStore
//    func getUserDefaultsStore() -> UserDefaultsStore {
//        return UserDefaultsStore(withUserDefaultsManager: UserDefaults())
//    }
}


