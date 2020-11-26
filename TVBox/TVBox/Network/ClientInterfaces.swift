//
//  ClientInterfaces.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation

enum ClientError: Error {
    case networkError(Error)
    case dataNotFound
    case invalidURL
    case jsonParsingError(Error)
    case unauthorized
    func errorMessage() -> String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("An error occurred connecting to the server. You can try again..", comment: "error_timeout")
        case .networkError:
            return NSLocalizedString("It seems you\'re not connected to the internet.", comment: "error_server")
        case .dataNotFound:
            return NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server")
        case .unauthorized:
            return NSLocalizedString("Sorry, Unuthorized user", comment: "error_user")
        case .jsonParsingError(_):
            return NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server")
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(ClientError)
}

protocol Request {
    var path: String { get }
    var parameters: Any? { get }
    var method: String { get }
    var headers: [String:String]? { get }
}
