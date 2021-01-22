//
//  Encodable+LeonMovies.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary(encoder: JSONEncoder) throws -> [String: Any] {
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
