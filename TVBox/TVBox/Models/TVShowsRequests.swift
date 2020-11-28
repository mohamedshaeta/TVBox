//
//  TVShowsRequests.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
enum TVShowsRequests: Request {
    
    case fetchTVShows
    case fetchTVShowDetails(tvShowId: Int)
    case fetchTVShowImages(tvShowId: Int)
    case fetchSimilarTVShows(tvShowId: Int)
    case rateTVShow(tvShowId: Int, value: Double, guestSessionId: String)
    
    var path: String {
        switch self {
        case .fetchTVShows:
            return "tv/on_the_air?api_key=\(Keys.Moviedb_API_Key)"
        case .fetchTVShowDetails(let tvShowId):
            return "tv/\(tvShowId)?api_key=\(Keys.Moviedb_API_Key)"
        case .fetchTVShowImages(let tvShowId):
            return "tv/\(tvShowId)/images?api_key=\(Keys.Moviedb_API_Key)"
        case .fetchSimilarTVShows(let tvShowId):
            return "tv/\(tvShowId)/similar?api_key=\(Keys.Moviedb_API_Key)"
        case .rateTVShow(let tvShowId, _, let guestSessionId):
            return "tv/\(tvShowId)/rating?api_key=\(Keys.Moviedb_API_Key)&guest_session_id=\(guestSessionId)"
        }
    }
    
    var parameters: Any? {
        switch self {
        case .fetchTVShows:
            return nil
        case .fetchTVShowDetails:
            return nil
        case .fetchTVShowImages:
            return nil
        case .fetchSimilarTVShows:
            return nil
        case .rateTVShow(_, let value,_):
            return ["value":value]
        }
    }
    
    var method: String {
        switch self {
        case .fetchTVShows:
            return "get"
        case .fetchTVShowDetails:
            return "get"
        case .fetchTVShowImages:
            return "get"
        case .fetchSimilarTVShows:
            return "get"
        case .rateTVShow:
            return "post"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}

