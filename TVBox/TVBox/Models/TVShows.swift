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

// MARK: - Result
struct TVShow: Codable {
    let posterPath, originalName: String?
    let id: Int?
    let popularity: Double?
    let overview, firstAirDate, name: String?
    let voteAverage: Double?
    let backdropPath: String?
    let voteCount: Int?
    let genreIDS: [Int]?
    let originCountry: [String]?
}

typealias TVShows = [TVShow]
