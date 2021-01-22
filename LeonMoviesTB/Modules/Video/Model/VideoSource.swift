//
//  VideoSource.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

enum VideoSource: String {
    case trailer
    case unknown
    
    init(type: String) {
        self = VideoSource(rawValue: type.lowercased()) ?? .unknown
    }
}
