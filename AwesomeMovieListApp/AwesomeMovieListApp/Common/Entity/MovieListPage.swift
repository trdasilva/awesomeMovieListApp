//
//  MovieListResponse.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieListPage : Mappable{
    
    var movieList: [Movie]?
    var currentPage: Int?
    var totalSize : Int?
    var totalPages : Int? 

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        movieList <- map["results"]
        currentPage <- map["page"]
        totalSize <- map["total_results"]
        totalPages <- map["total_pages"]
    }
}
