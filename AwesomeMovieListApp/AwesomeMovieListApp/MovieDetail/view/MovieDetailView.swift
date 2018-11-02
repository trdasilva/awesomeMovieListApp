//
//  MovieDetailView.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailView: UIViewController, MovieDetailPresenterToViewProtocol{
    
    @IBOutlet weak var movieBackdropImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    var presenter : MovieDetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        presenter?.viewLoaded()
    }
    
    func updateMovieInfo() {
        movieTitle.text = presenter?.getMovieTitle()
        movieGenres.text = presenter?.getMovieGenres()
        movieReleaseDate.text = presenter?.getMovieReleaseDate()
        movieOverview.text = presenter?.getMovieOverview()
        movieBackdropImage.loadImage(imageUrl: presenter?.getMovieImage())
    }
}
