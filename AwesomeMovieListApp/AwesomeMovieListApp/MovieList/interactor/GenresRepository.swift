//
//  GenresRepository.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 29/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxAlamofire_ObjectMapper
import RxSwift

class GenresRepository {
    private let genresUrl = "/genre/movie/list"
    
    func getGenres() -> (Observable<[Int:Genre]>) {
        
        let parameters: Parameters = [
            "api_key": Config.apiKey
        ]
        let getGenresUrl = Config.baseUrl + self.genresUrl
        
        return RxAlamofire.request(.get, getGenresUrl, parameters: parameters)
            .responseMappableArray(as: Genre.self, keyPath: "genres")
            .flatMap { (genresArray: [Genre]) -> (Observable<[Int:Genre]>) in
                let dictionary = Dictionary(uniqueKeysWithValues: genresArray.map{ ($0.id!, $0) })
                return Observable.just(dictionary)
        }
    }
}
