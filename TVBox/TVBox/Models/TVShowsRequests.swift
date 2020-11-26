//
//  TVShowsRequests.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
import Foundation
enum TVShowsRequests: Request {
    
    case tvShows
   
    var path: String {
        switch self {
        case .tvShows:
            return "on_the_air?api_key=dad24f3c5a920b4c0268dc409a1df75b"
        }
    }
    
    var parameters: Any? {
        switch self {
        case .tvShows:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .tvShows:
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

