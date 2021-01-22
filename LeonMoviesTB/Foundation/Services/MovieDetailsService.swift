//
//  MovieDetailsService.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

class MovieDetailsService: LMConnectionService {
    func syncVideos(movieId: String, completion: @escaping(_ response: VideoResults?, _ error: Error?) -> ()) {
        LMConnectionService.requestGET(url: String(format: LMConstants.Url.videos, movieId), parameters: Empty(), response: VideoResults.self) { (result, error, statusCode) in
            guard error == nil, let result = result as? VideoResults else {
                completion(nil, error)
                return
            }
            completion(result, nil)
        }
    }
}
