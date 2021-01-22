//
//  MovieDetailsViewModel.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelDelegate: class {
    var delegate: MovieDetailsViewControllerDelegate? { get set }
    func syncVideos(for movie: Movie?)
}

class MovieDetailsViewModel: MovieDetailsViewModelDelegate {
    weak var delegate: MovieDetailsViewControllerDelegate?
    private var service = MovieDetailsService()
    
    func syncVideos(for movie: Movie?) {
        guard let movieId = movie?.id else {
            self.delegate?.fetchVideo(url: nil, message: "leonMovies.movieDetail.movieWithoutIdMessage".localized())
            return
        }
        service.syncVideos(movieId: "\(movieId)") { [weak self] (result, error) in
            guard let result = result else {
                self?.delegate?.fetchVideo(url: nil, message: "leonMovies.common.errorMessage".localized())
                return
            }
            if result.results.isEmpty {
                self?.delegate?.fetchVideo(url: nil, message: "leonMovies.movieDetail.movieWithoutVideoMessage".localized())
            } else if let index = result.results.firstIndex(where: { $0.source == .trailer }) {
                self?.delegate?.fetchVideo(url: URL(string: LMConstants.Url.baseVideo + result.results[index].key), message: nil)
            } else {
                self?.delegate?.fetchVideo(url: URL(string: LMConstants.Url.baseVideo + result.results[0].key), message: nil)
            }
        }
    }
}
