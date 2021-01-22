//
//  String+LeonMovies.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: (self), comment: "")
    }
}
