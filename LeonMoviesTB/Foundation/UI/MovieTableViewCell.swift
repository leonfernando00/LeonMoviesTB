//
//  MovieTableViewCell.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class MovieTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var circularProgressBar: MBCircularProgressBarView!
    
    //MARK: Vars
    var movie: Movie? {
        didSet {
            prepareCell()
        }
    }
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    //MARK: Functions
    func prepareCell() {
        movieImageView.setImage(fromURL: movie?.posterUrl, withProgressiveLoad: true, withBaseUrl: true)
        movieTitleLabel.text = movie?.title
        movieYearLabel.text = movie?.releaseYear
        setupCircularProgressBar(rating: CGFloat(movie?.rating ?? 0))
    }
    
    private func setupCircularProgressBar(rating: CGFloat) {
        UIView.animate(withDuration: 0.75) {
            self.circularProgressBar.value = rating
        }
        let color: UIColor = rating == 0 ? .darkGray : rating > 7.0 ? .green : rating > 4.9 ? .yellow : .red
        circularProgressBar.progressColor = color
        circularProgressBar.progressStrokeColor = color
    }
}
