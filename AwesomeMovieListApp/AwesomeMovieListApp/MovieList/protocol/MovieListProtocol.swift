//
//  MovieListProtocol.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol PresenterToInteractorProtocol {
    func getMoviesList() -> (Observable<[Movie]>)
}

protocol ViewToPresenterProtocol{
    func viewLoaded()
    func viewDisappeared()
    func getNumberOfRowForSecton(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getMovieTitleForRow(rowNumber: Int) -> String?
    func getMovieGenresForRow(rowNumber: Int) -> String?
    func getMovieReleaseDateForRow(rowNumber: Int) -> String?
}

protocol PresenterToViewProtocol {
    func updateTableView()
}

