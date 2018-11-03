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
    func getMovieListPage(pageNumber: Int) -> (Observable<MovieListPage>)
}

protocol MovieListViewToPresenterProtocol{
    func viewLoaded()
    func isMovieDataAvailable(index: IndexPath) -> Bool
    func isPrefetchNeeded(index: IndexPath) -> Bool
    func prefetchMoreMovies()
    func getNumberOfRowForSecton(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getMovieTitleForRow(rowNumber: Int) -> String?
    func getMovieGenresForRow(rowNumber: Int) -> String?
    func getMovieReleaseDateForRow(rowNumber: Int) -> String?
    func getMovieImageForRow(rowNumber: Int) ->URL?
    func movieSelected(rowNumber: Int)
    func filterMovieList(searchText: String)
}

protocol MovieListPresenterToViewProtocol {
    func updateTableView()
    func isSearchBeingUsed() -> Bool
}

protocol MovieListPresenterToRouterProtocol {
    func showMovieDetail(movieData: Movie)
}

