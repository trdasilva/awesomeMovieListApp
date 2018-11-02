//
//  MovieDetailRouter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter{
    
    class func createMovieDetailModule(movie: Movie?) -> UIViewController? {
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailView")
        
        if let view = viewController as? MovieDetailView {
            let presenter: MovieDetailPresenter = MovieDetailPresenter()
            
            view.presenter = presenter as MovieDetailViewToPresenterProtocol
            presenter.view = view as MovieDetailPresenterToViewProtocol
            presenter.movieData = movie

            return viewController
        }else{
            return nil
        }
    }
    
    private static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
