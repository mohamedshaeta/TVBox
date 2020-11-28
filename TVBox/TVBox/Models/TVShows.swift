//
//  TVShows.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation

// MARK: - TVShows
struct TVShowsResponse: Codable {
    let totalPages: Int?
    let results: TVShows?
    let totalResults, page: Int?

}

// MARK: - TVShow
struct TVShow: Codable {
    let voteAverage: Double?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let name: String?
    let networks: [Network]?
    let numberOfEpisodes: Int?
    let posterPath: String?
    let overview: String?
    let voteCount: Int?
    var images: TVShowImages?
    let lastEpisodeToAir: TEpisodeToAir?
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int?
    let creditID, name: String?
    let gender: Int?
    let profilePath: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - TEpisodeToAir
struct TEpisodeToAir: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
}

// MARK: - Network
struct Network: Codable {
    let name: String?
    let id: Int?
    let logoPath: String?
}

// MARK: - TVShowImages
struct TVShowImages: Codable {
    let id: Int?
    let posters: Posters?
    let backdrops: Posters?
    
}

// MARK: - Backdrop
struct Poster: Codable {
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let width: Int?
}

// MARK: - RateResponse
struct RateResponse: Codable {
    let statusCode: Int?
    let statusMessage: String?
}


typealias TVShows = [TVShow]
typealias Posters = [Poster]
