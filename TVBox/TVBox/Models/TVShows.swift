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
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let lastAirDate: String?
    let lastEpisodeToAir: TEpisodeToAir?
    let name: String?
    let nextEpisodeToAir: TEpisodeToAir?
    let networks: [Network]?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?
    var images: TVShowImages?
    
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
    let name, overview, productionCode: String?
    let seasonNumber: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
}

// MARK: - Network
struct Network: Codable {
    let name: String?
    let id: Int?
    let logoPath, originCountry: String?
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
    let voteAverage: Double?
    let voteCount, width: Int?
}


typealias TVShows = [TVShow]

typealias Posters = [Poster]
