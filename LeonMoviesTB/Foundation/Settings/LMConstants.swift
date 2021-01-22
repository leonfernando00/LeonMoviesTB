//
//  LMConstants.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import Foundation

struct LMConstants {
    
    static let language = Locale.current.languageCode == "es" ? "es" : "en"
    
    struct Url {
        static let base = "https://api.themoviedb.org/3/movie/"
        static let baseImage = "https://image.tmdb.org/t/p/w1280"
        static let movies = "%@?api_key=\(Key.apiKey)&language=\(language)-US&page=%@"
        static let baseVideo = "https://www.youtube.com/embed/"
        static let videos = "%@/videos?api_key=\(Key.apiKey)&language=\(language)-US"
    }
    
    struct Key {
        static let apiKey = "beeb60b8e4df310d5161674889594fba"
    }
    
    struct AccessibilityIdentifier {
        static let tableView = "main_tableView"
        static let navBarRightButton = "nav_right_button"
        static let playVideoButton = "playVideo_button"
        static let cell = "cell_%@"
        static let firstCell = "cell_0"
        static let secondCell = "cell_1"
        static let fifthCell = "cell_4"
        static let sixthCell = "cell_5"
    }
}
