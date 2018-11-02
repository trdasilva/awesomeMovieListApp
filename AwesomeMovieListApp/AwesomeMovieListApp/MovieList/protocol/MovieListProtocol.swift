//
//  MovieListProtocol.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieListPresenterToInteractorProtocol {
    func getMoviesList() -> (Observable<[Movie]>)
}

protocol MovieListViewToPresenterProtocol{
    func viewLoaded()
    func getNumberOfRowForSecton(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getMovieTitleForRow(rowNumber: Int) -> String?
    func getMovieGenresForRow(rowNumber: Int) -> String?
    func getMovieReleaseDateForRow(rowNumber: Int) -> String?
    func getMovieImageForRow(rowNumber: Int) ->URL?
    func movieSelected(rowNumber: Int)
}

protocol MovieListPresenterToViewProtocol {
    func updateTableView()
}

protocol MovieListPresenterToRouterProtocol {
    func showMovieDetail(movieData: Movie)
}

