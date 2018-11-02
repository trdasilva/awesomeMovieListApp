//
//  MovieListDataManager.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListDataManager: PresenterToInteractorProtocol{
    let moviesRepository = MoviesRepository()
    let genresRepository = GenresRepository()
    
    
    func getMoviesList() -> (Observable<[Movie]>){
        return combineMovieListWithGenre()
    }
    
    private func combineMovieListWithGenre() -> (Observable<[Movie]>) {
        
        return Observable.zip(moviesRepository.getMovies(),genresRepository.getGenres())
            .flatMap { (arg: ([Movie], [Int : Genre])) ->
                (Observable<[Movie]>) in
                    let (movieList, genreDic) = arg
                
                for movie in movieList {
                    movie.genreIds?.forEach({ (genreId: Int) in
                        let genre = genreDic[genreId]
                        
                        if(movie.genres == nil){
                            movie.genres = genre?.name
                        }else{
                            movie.genres?.append(", " + (genre?.name!)!)
                        }
                    })
                }
                
            return Observable.just(movieList)
        }
    }
}
