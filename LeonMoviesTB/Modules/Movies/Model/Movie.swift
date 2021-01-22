//
//  Movie.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

struct Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case rating = "vote_average"
        case posterUrl = "poster_path"
        case backdropUrl = "backdrop_path"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
    }
    
    let id: Int
    let title: String
    let overview: String?
    let rating: Double?
    let posterUrl: String?
    let backdropUrl: String?
    let releaseDate: String?
    let voteCount: Int?
}

extension Movie {
    var releaseYear: String {
        if let releaseDate = releaseDate {
            return String(releaseDate.prefix(4))
        }
        return "leonMovies.movieDetail.defaultDate".localized()
    }
}
