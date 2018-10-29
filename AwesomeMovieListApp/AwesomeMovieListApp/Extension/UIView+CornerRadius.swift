//
//  UIView+CornerRadius.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 28/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
