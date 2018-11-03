//
//  MovieListDataManager.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListDataManager: MovieListPresenterToInteractorProtocol{
    let moviesRepository = MoviesRepository()
    let genresRepository = GenresRepository()
    
    func getMovieListPage(pageNumber: Int) -> (Observable<MovieListPage>){
        return combineMovieListPageWithGenre(page: pageNumber)
    }
    
    private func combineMovieListPageWithGenre(page: Int) -> (Observable<MovieListPage>) {
        
        return Observable.zip(moviesRepository.getMoviesPage(page: page),genresRepository.getGenres())
            .flatMap { (arg: (MovieListPage, [Int : Genre])) ->
                (Observable<MovieListPage>) in
                    let (movieResponse, genreDic) = arg
                
                movieResponse.movieList?.forEach({ movie in
                       movie.genres = self.getMovieGenres(movie: movie, genres: genreDic)
                })
                
                return Observable.just(movieResponse)
        }
    }
    
    private func getMovieGenres(movie: Movie, genres: [Int : Genre]) -> String?{
        var genreText: String? = nil
        
        movie.genreIds?.forEach({ (genreId: Int) in
            let genre = genres[genreId]
            if(genreText == nil){
                genreText = genre?.name
            }else{
                genreText?.append(", " + (genre?.name!)!)
            }
        })
        
        return genreText
    }
}
