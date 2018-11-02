//
//  UIImageView+ImageLoader.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView{
    
    func loadImage(imageUrl: URL?){
        let placeholderImage = UIImage(named: "image_placeholder")!
        self.image = placeholderImage
        
        if let url = imageUrl {
            self.af_setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                imageTransition: .crossDissolve(0.2)
            )
        }
    }
}
