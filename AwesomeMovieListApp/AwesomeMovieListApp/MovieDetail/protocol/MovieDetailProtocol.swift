//
//  MovieDetailProtocol.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation

protocol MovieDetailViewToPresenterProtocol{
    func viewLoaded()
    func getMovieTitle() -> String?
    func getMovieGenres() -> String?
    func getMovieImage() ->URL?
    func getMovieReleaseDate() -> String?
    func getMovieOverview() -> String?
}

protocol MovieDetailPresenterToViewProtocol {
    func updateMovieInfo()
}
