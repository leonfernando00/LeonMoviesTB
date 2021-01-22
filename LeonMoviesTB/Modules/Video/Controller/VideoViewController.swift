//
//  VideoViewController.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 21/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIView!
    
    //MARK: Vars
    var url: URL?

    //MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setupView()
    }
    
    //MARK: Functions
    func setupView() {
        showAnimate()
        guard let url = url else {
            showAlert(title: "leonMovies.common.errorTitle".localized(), message: "leonMovies.common.errorMessage".localized())
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    private func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    
    //MARK: Actions
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        removeAnimate()
    }
}

//MARK: WKNavigationDelegate
extension VideoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.isHidden = true
    }
}
