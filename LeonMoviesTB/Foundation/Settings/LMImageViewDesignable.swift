//
//  LMImageViewDesignable.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit

class LMImageViewDesignable: UIImageView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
        
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
        
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
        
    override func layoutSubviews() {
        self.layer.cornerRadius = cornerRadius == -1 ? frame.size.height / 2 : cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
}
