//
//  MoviesRepository.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 28/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxAlamofire_ObjectMapper
import RxSwift

class MoviesRepository{
    
    private let upcomingMovieUrl = "/movie/upcoming"
    
    func getMovies() -> (Observable<[Movie]>){
        return combineMovieListWithGenre(movieList: getMoviesFromRemote())
    }
    
    private func combineMovieListWithGenre(movieList: Observable<[Movie]>) -> (Observable<[Movie]>) {
        
        return Observable.zip(movieList,GenresRepository().getGenres())
            .flatMap { (arg: ([Movie], [Int : Genre])) ->
                (Observable<[Movie]>) in
                
                let (arg0, arg1) = arg
                for movie in arg0 {
                    movie.genreIds?.forEach({ (genreId: Int) in
                        let genre = arg1[genreId]
                        
                        if(movie.genres == nil){
                            movie.genres = [String]()
                        }
                        movie.genres?.append((genre?.name!)!)
                    })
                }
                
                return Observable.just(arg0)
        }
    }
    
    private func getMoviesFromRemote() -> (Observable<[Movie]>) {
        
        let parameters: Parameters = [
            "api_key": Config.apiKey
        ]
        let getUpcomingMovieUrl = Config.baseUrl + self.upcomingMovieUrl
        
        return RxAlamofire.request(.get ,getUpcomingMovieUrl, parameters: parameters)
            .responseMappableArray(as: Movie.self, keyPath: "results")
    }
}
