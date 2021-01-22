//
//  UIViewController+LeonMovies.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttons: [UIAlertAction] = [UIAlertAction(title: "leonMovies.common.ok".localized(), style: .default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for button in buttons {
            alert.addAction(button)
        }
        present(alert, animated: true, completion: nil)
    }
}
