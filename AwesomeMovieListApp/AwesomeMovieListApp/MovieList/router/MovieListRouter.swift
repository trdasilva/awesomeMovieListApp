//
//  MovieListRouter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter {
    
    private var movieDataToSend: Movie?
    
    class func createMovieListModule(movieListView: MovieListView) {
        
            let presenter = MovieListPresenter()
            let interactor = MovieListDataManager()
            //let router = MovieListRouter()
            
            movieListView.presenter = presenter as MovieListViewToPresenterProtocol
            presenter.view = movieListView as MovieListPresenterToViewProtocol
            presenter.intereactor = interactor as MovieListPresenterToInteractorProtocol
       }
    
    private static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
