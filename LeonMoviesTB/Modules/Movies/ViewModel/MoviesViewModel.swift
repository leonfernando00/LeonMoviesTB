//
//  MoviesViewModel.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
    var delegate: MoviesViewControllerDelegate? { get set }
    func syncMovies(categoryType: CategoryType)
}

class MoviesViewModel: MoviesViewModelDelegate {
    weak var delegate: MoviesViewControllerDelegate?
    var numberOfPage = 1
    var selectedCategoryType: CategoryType = .popular
    private var service = MoviesService()
    
    func syncMovies(categoryType: CategoryType) {
        let categoryDidChange: Bool = categoryType != selectedCategoryType
        numberOfPage = categoryDidChange ? 1 : numberOfPage
        selectedCategoryType = categoryType
        service.syncMovies(categoryPath: categoryType, numberOfPage: numberOfPage) { [weak self] (result, error) in
            guard error == nil else {
                self?.delegate?.fetchMovies(movies: nil, error: error, categoryDidChange: categoryDidChange)
                return
            }
            self?.numberOfPage += 1
            self?.delegate?.fetchMovies(movies: result?.results, error: nil, categoryDidChange: categoryDidChange)
        }
    }
}
