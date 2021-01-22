//
//  ImageCache+LeonMovies.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit
import SDWebImage

protocol CanSetImageFromURL {
    func setImage(fromURL url: String?, withProgressiveLoad: Bool, withBaseUrl: Bool)
}

extension UIImageView: CanSetImageFromURL {
    func setImage(fromURL url: String?, withProgressiveLoad: Bool, withBaseUrl: Bool) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.sd_setImage(with: URL(string: (withBaseUrl ? LMConstants.Url.baseImage : "") + (url ?? "")), placeholderImage: nil, options: withProgressiveLoad ? [.progressiveLoad] : [])
    }
}

extension UIButton: CanSetImageFromURL {
    func setImage(fromURL url: String?, withProgressiveLoad: Bool, withBaseUrl: Bool) {
        self.sd_setImage(with: URL(string: (withBaseUrl ? LMConstants.Url.baseImage : "") + (url ?? "")), for: .normal)
    }
}
