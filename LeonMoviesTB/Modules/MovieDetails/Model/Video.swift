//
//  Video.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

struct Video: Codable {
    let key: String
    let type: String
}

extension Video {
    var source: VideoSource {
        return VideoSource(type: type)
    }
}
