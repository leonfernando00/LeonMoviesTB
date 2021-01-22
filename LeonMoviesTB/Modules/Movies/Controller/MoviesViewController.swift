//
//  MoviesViewController.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit

protocol MoviesViewControllerDelegate: class {
    func fetchMovies(movies: [Movie]?, error: Error?, categoryDidChange: Bool)
}

class MoviesViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Vars
    var movies: [Movie] = []
    var selectedCategoryType: CategoryType = .popular
    var isLoading = true
    let viewModel: MoviesViewModelDelegate = MoviesViewModel()
    
    //MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedCategoryType.navigationTitle
        setupTableView()
        setupNavigationBarButton()
        viewModel.delegate = self
        viewModel.syncMovies(categoryType: selectedCategoryType)
    }
    
    //MARK: Functions
    func setupTableView() {
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = LMConstants.AccessibilityIdentifier.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func setupNavigationBarButton() {
        let button = UIBarButtonItem(title: "leonMovies.movies.categoriesTitle".localized(), style: .done, target: self, action: #selector(showChangeCategoryAlert))
        button.accessibilityIdentifier = LMConstants.AccessibilityIdentifier.navBarRightButton
        navigationItem.rightBarButtonItem = button
    }
        
    @objc func showChangeCategoryAlert() {
        let options = UIAlertController(title: "leonMovies.movies.changeCategoryTitle".localized(), message: "leonMovies.movies.changeCategoryMessage".localized(), preferredStyle: .actionSheet)
        options.addAction(UIAlertAction(title: CategoryType.popular.navigationTitle, style: .default, handler: { (alert) in
            self.changeCategory(for: .popular)
        }))
        options.addAction(UIAlertAction(title: CategoryType.topRated.navigationTitle, style: .default, handler: { (alert) in
            self.changeCategory(for: .topRated)
        }))
        options.addAction(UIAlertAction(title: CategoryType.upcoming.navigationTitle, style: .default, handler: { (alert) in
            self.changeCategory(for: .upcoming)
        }))
        options.addAction(UIAlertAction(title: "leonMovies.movies.cancelTitle".localized(), style: .cancel, handler: nil))
        present(options, animated: true, completion: nil)
    }
    
    func changeCategory(for category: CategoryType) {
        guard category != selectedCategoryType else { return }
        selectedCategoryType = category
        viewModel.syncMovies(categoryType: selectedCategoryType)
    }
}

//MARK:- TableView Configuration
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.accessibilityIdentifier = String(format: LMConstants.AccessibilityIdentifier.cell, "\(indexPath.row)")
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movies[indexPath.row]
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shouldLoadMore = indexPath.row == (movies.count - 2)
        if shouldLoadMore && !isLoading {
            isLoading = true
            viewModel.syncMovies(categoryType: selectedCategoryType)
        }
    }
}

//MARK:- MoviesViewControllerProtocol
extension MoviesViewController: MoviesViewControllerDelegate {
    func fetchMovies(movies: [Movie]?, error: Error?, categoryDidChange: Bool) {
        isLoading = false
        guard let movies = movies, error == nil else {
            showAlert(title: "leonMovies.common.errorTitle".localized(), message: "leonMovies.common.errorMessage".localized())
            return
        }
        title = selectedCategoryType.navigationTitle
        if categoryDidChange {
            tableView.setContentOffset(.zero, animated: false)
            self.movies = movies
        } else {
            self.movies.append(contentsOf: movies)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
