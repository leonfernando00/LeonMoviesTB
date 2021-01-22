//
//  MovieDetailsViewController.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit
import MBCircularProgressBar

protocol MovieDetailsViewControllerDelegate: class {
    func fetchVideo(url: URL?, message: String?)
}

class MovieDetailsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var backdropImageAlpha: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var circularProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var voteCountTitleLabel: UILabel!
    @IBOutlet weak var voteCountValueLabel: UILabel!
    @IBOutlet weak var releaseDateTitleLabel: UILabel!
    @IBOutlet weak var releaseDateValueLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: LMLocalizedLabel!
    @IBOutlet weak var overviewValueLabel: UILabel!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
    //MARK: Vars
    var movie: Movie?
    let viewModel: MovieDetailsViewModelDelegate = MovieDetailsViewModel()
    
    //MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
    }
    
    //MARK: Functions
    func setupView() {
        backdropImage.setImage(fromURL: movie?.backdropUrl, withProgressiveLoad: true, withBaseUrl: true)
        backdropImageAlpha.setImage(fromURL: movie?.backdropUrl, withProgressiveLoad: false, withBaseUrl: true)
        posterImage.setImage(fromURL: movie?.posterUrl, withProgressiveLoad: true, withBaseUrl: true)
        titleLabel.text = movie?.title
        voteCountValueLabel.text = "\(movie?.voteCount ?? 0) " + "leonMovies.movieDetail.votes".localized()
        releaseDateValueLabel.text = movie?.releaseDate ?? "leonMovies.movieDetail.defaultDate".localized()
        overviewValueLabel.text = movie?.overview ?? "leonMovies.movieDetail.defaultOverview".localized()
        setupColor(with: CGFloat(movie?.rating ?? 0))
    }
    
    func setupColor(with rating: CGFloat) {
        UIView.animate(withDuration: 0.75) {
            self.circularProgressBar.value = rating
        }
        let color: UIColor = rating == 0 ? .gray : rating > 7.0 ? .green : rating > 4.9 ? .yellow : .red
        circularProgressBar.progressColor = color
        circularProgressBar.progressStrokeColor = color
        for label in [voteCountTitleLabel, releaseDateTitleLabel, overviewTitleLabel] as [UILabel] {
            label.textColor = color
        }
    }
    
    func showLoader(_ show : Bool) {
        playVideoButton.isEnabled = !show
        activityIndicator.isHidden = !show
    }
    
    //MARK: Actions
    @IBAction func didTapPlayVideoButton(_ sender: UIButton) {
        showLoader(true)
        viewModel.syncVideos(for: movie)
    }
}

//MARK:- MovieDetailsViewControllerDelegate
extension MovieDetailsViewController: MovieDetailsViewControllerDelegate {
    func fetchVideo(url: URL?, message: String?) {
        showLoader(false)
        guard let url = url else {
            showAlert(title: "leonMovies.common.errorTitle".localized(), message: message ?? "leonMovies.common.errorMessage".localized())
            return
        }
        let videoViewController = VideoViewController()
        videoViewController.url = url
        self.addChild(videoViewController)
        videoViewController.view.frame = view.frame
        self.view.addSubview(videoViewController.view)
        videoViewController.didMove(toParent: self)
    }
}
