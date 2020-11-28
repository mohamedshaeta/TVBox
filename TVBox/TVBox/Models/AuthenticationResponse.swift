//
//  AuthenticationResponse.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
// MARK: - TVShowImages
struct AuthenticationResponse: Codable {
    let success: Bool?
    let guestSessionId, expiresAt: String?
}
