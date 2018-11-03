//
//  MovieListPresenter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListPresenter : MovieListViewToPresenterProtocol {
    
    var intereactor : MovieListPresenterToInteractorProtocol?
    var view: MovieListPresenterToViewProtocol?
    var router: MovieListPresenterToRouterProtocol?
    
    let disposeBag = DisposeBag()
    var  movieList : [Movie]? = nil
    var  filteredMovieList : [Movie]? = nil
    var currentPage: Int = 0
    var totalPages: Int = 0
    var totalMovies: Int = 0
    
    var isLoadingMovies = false
    
    func viewLoaded() {
        getMoreMovies()
    }
    
    func isPrefetchNeeded(index: IndexPath) -> Bool{
        return !isMovieDataAvailable(index:index)
    }
    
    func isMovieDataAvailable(index: IndexPath) -> Bool{
        if(index.row < movieList?.count ?? 0){
            return true
        }else{
            return false
        }
    }
    
    func prefetchMoreMovies(){
        getMoreMovies()
    }
    
    func filterMovieList(searchText: String) {
        filteredMovieList = movieList?.filter{ movie -> Bool in
            return movie.title?.uppercased().contains(searchText.uppercased()) ?? false
        }
        view?.updateTableView()
    }

    
    private func getMoreMovies(){
        fetchMoviesPage(page: currentPage + 1)
    }
    
    private func fetchMoviesPage(page: Int){
        
        guard !isLoadingMovies else {
            return
        }
        isLoadingMovies = true
        
        intereactor?.getMovieListPage(pageNumber: page).subscribe(
            onNext: { moviePage in
                self.updateMovieInfo(moviePage: moviePage)
        },
            onError: { error in
                print("An error occurred :" + error.localizedDescription)
                self.isLoadingMovies = false
        },
            onCompleted: {
                self.view?.updateTableView()
                self.isLoadingMovies = false
        }
            ).disposed(by: disposeBag)
    }
    
    private func updateMovieInfo(moviePage: MovieListPage){
        self.currentPage = moviePage.currentPage!
        self.totalPages = moviePage.totalPages!
        self.totalMovies = moviePage.totalSize!
        
        if let movies = moviePage.movieList{
            if(movieList == nil){
                self.movieList = movies
            }else{
                self.movieList?.append(contentsOf: movies)
            }
        }
    }
    
    private func getCurrentMovieSource() -> [Movie]? {
        if(view?.isSearchBeingUsed() ?? false){
            return filteredMovieList
        }else{
            return movieList
        }
    }
    
    func getNumberOfRowForSecton(section: Int) -> Int {
        if(view?.isSearchBeingUsed() ?? false){
            return filteredMovieList?.count ?? 0
        }
        return totalMovies
    }
    
    func getNumberOfSections() -> Int{
        return 1
    }
    
    func getMovieTitleForRow(rowNumber: Int) -> String?{
        return getCurrentMovieSource()?[rowNumber].title
    }
    
    func getMovieGenresForRow(rowNumber: Int) -> String?{
        return getCurrentMovieSource()?[rowNumber].genres
    }
    
    func getMovieImageForRow(rowNumber: Int) ->URL?{
        if let backdropUrl = getCurrentMovieSource()?[rowNumber].backdropImageUrl {
                return backdropUrl
        }else{
            return getCurrentMovieSource()?[rowNumber].posterImageUrl
        }
    }
    
    func getMovieReleaseDateForRow(rowNumber: Int) -> String?{
        return getCurrentMovieSource()?[rowNumber].releaseDate
    }
    
    func movieSelected(rowNumber: Int) {
        if let movie = getCurrentMovieSource()?[rowNumber] {
            router?.showMovieDetail(movieData: movie)
        }
    }
}
