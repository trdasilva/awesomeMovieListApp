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
    
    public func getMoviesPage(page: Int) -> (Observable<MovieListPage>) {
        
        let parameters: Parameters = [
            "api_key": Config.apiKey,
            "page": page
        ]
        let getUpcomingMovieUrl = Config.baseUrl + self.upcomingMovieUrl
        
        return RxAlamofire.request(.get ,getUpcomingMovieUrl, parameters: parameters)
            .responseMappable(as: MovieListPage.self)
    }
}
