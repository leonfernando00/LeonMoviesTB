//
//  CategoryType.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

enum CategoryType {
    case popular
    case topRated
    case upcoming
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .popular:
            return "leonMovies.movies.popularTitle".localized()
        case .topRated:
            return "leonMovies.movies.topRatedTitle".localized()
        case .upcoming:
            return "leonMovies.movies.upcomingTitle".localized()
        }
    }
}
