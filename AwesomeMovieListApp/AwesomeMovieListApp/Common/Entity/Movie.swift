//
//  Movie.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 28/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie : Mappable  {

    var id: Int?
    var title: String?
    var genreIds: [Int]?
    var genres: String?
    private var backdropImagePath: String?
    private var posterImagePath: String?
    var releaseDate: String?
    var overview: String?
    
    var backdropImageUrl: URL? {
        get {
            if let url = backdropImagePath {
                return URL(string: Config.backdropImageBaseUrl
                + url
                + "?api_key="
                + Config.apiKey)
            }else{
                return nil
            }
        }
    }
    
    var posterImageUrl: URL? {
        get {
            if let url = posterImagePath {
                return URL(string: Config.posterImageBaseUrl
                    + url
                    + "?api_key="
                    + Config.apiKey)
            }else{
                return nil
            }
        }
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        genreIds <- map["genre_ids"]
        backdropImagePath <- map["backdrop_path"]
        posterImagePath <- map["poster_path"]
        releaseDate <- map["release_date"]
        overview <- map["overview"]
    }
}
