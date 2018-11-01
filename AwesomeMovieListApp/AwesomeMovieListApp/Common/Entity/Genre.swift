//
//  Genre.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 29/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class Genre: Mappable {
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
