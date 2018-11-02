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

class MoviesRepository : PresenterToInteractorProtocol{
    
    private let upcomingMovieUrl = "/movie/upcoming"
    
    func getMoviesList() -> (Observable<[Movie]>){
        return combineMovieListWithGenre(movieListObservable: getMoviesFromRemote())
    }
    
    private func combineMovieListWithGenre(movieListObservable: Observable<[Movie]>) -> (Observable<[Movie]>) {
        
        return Observable.zip(movieListObservable,GenresRepository().getGenres())
            .flatMap { (arg: ([Movie], [Int : Genre])) ->
                (Observable<[Movie]>) in
                
                let (movieList, genreDic) = arg
                for movie in movieList {
                    movie.genreIds?.forEach({ (genreId: Int) in
                        let genre = genreDic[genreId]
                        
                        if(movie.genres == nil){
                            movie.genres = [String]()
                        }
                        movie.genres?.append((genre?.name!)!)
                    })
                }
                return Observable.just(movieList)
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
