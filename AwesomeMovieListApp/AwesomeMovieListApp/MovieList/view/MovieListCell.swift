//
//  MovieListCell.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 28/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

}
