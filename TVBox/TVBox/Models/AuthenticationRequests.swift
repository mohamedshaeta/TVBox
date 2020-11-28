//
//  AuthenticationRequests.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//


import Foundation
enum AuthenticationRequests: Request {
    
    case fetchGuestSessionId
    
    var path: String {
        switch self {
        case .fetchGuestSessionId:
            return "authentication/guest_session/new?api_key=\(Keys.Moviedb_API_Key)"
        }
    }
    
    var parameters: Any? {
        switch self {
        case .fetchGuestSessionId:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .fetchGuestSessionId:
            return "get"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}


