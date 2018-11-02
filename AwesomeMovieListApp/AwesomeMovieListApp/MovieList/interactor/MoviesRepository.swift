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
    
    public func getMovies() -> (Observable<[Movie]>) {
        
        let parameters: Parameters = [
            "api_key": Config.apiKey
        ]
        let getUpcomingMovieUrl = Config.baseUrl + self.upcomingMovieUrl
        
        return RxAlamofire.request(.get ,getUpcomingMovieUrl, parameters: parameters)
            .responseMappableArray(as: Movie.self, keyPath: "results")
    }
}
