//
//  LeonMoviesTBTests.swift
//  LeonMoviesTBTests
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import XCTest
@testable import LeonMoviesTB

class LeonMoviesTBTests: XCTestCase {
    
    func testPopularMovies() {
        testMoviesService(category: .popular)
    }
    
    func testTopRatedMovies() {
        testMoviesService(category: .topRated)
    }
    
    func testUpcomingMovies() {
        testMoviesService(category: .upcoming)
    }
    
    func testMoviesService(category: CategoryType) {
        let service = MoviesService()
        let promise = expectation(description: "Success")
        service.syncMovies(categoryPath: category) { (response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 30)
    }
    
    func testMovieVideosService() {
        let service = MovieDetailsService()
        let promise = expectation(description: "Success")
        let movieTest: Movie = Movie(id: 464052, title: "Wonder Woman 1984", overview: "Overview", rating: 7.1, posterUrl: nil, backdropUrl: nil, releaseDate: "2020-12-16", voteCount: 2904)
        service.syncVideos(movieId: "\(movieTest.id)") { (response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 30)
    }
}
