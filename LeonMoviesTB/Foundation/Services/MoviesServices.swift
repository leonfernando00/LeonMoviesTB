//
//  MoviesServices.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

class MoviesService: LMConnectionService {
    func syncMovies(categoryPath: CategoryType, numberOfPage: Int = 1, completion: @escaping(_ response: MovieResults?, _ error: Error?) -> ()) {
        LMConnectionService.requestGET(url: String(format: LMConstants.Url.movies, categoryPath.path, "\(numberOfPage)"), parameters: Empty(), response: MovieResults.self) { (result, error, statusCode) in
            guard error == nil, let result = result as? MovieResults else {
                completion(nil, error)
                return
            }
            completion(result, nil)
        }
    }
}
