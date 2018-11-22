//
//  MovieListRouter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter : MovieListPresenterToRouterProtocol{
    
    weak var viewController: UIViewController?
    
    class func createMovieListModule(view: MovieListView) {
        
            let presenter = MovieListPresenter()
            let interactor = MovieListDataManager()
            let router = MovieListRouter()
            
            view.presenter = presenter as MovieListViewToPresenterProtocol
            presenter.view = view as MovieListPresenterToViewProtocol
            presenter.intereactor = interactor as MovieListPresenterToInteractorProtocol
            presenter.router = router as MovieListPresenterToRouterProtocol
            router.viewController = view
    }
    
    func showMovieDetail(movieData: Movie) {
        
        if let movieDetailView = MovieDetailRouter.createMovieDetailModule(movie: movieData){
            if let sourceView = viewController {
                sourceView.navigationController?.pushViewController(movieDetailView, animated: true)
            }
        }
    }
}
