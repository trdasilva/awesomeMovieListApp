//
//  MovieListRouterTeste.swift
//  AwesomeMovieListAppTests
//
//  Created by Tomaz Rocha Silva on 11/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import XCTest
@testable import AwesomeMovieListApp

class MovieListRouterTest : XCTest {
    
    func testCreationOfMovieListModule(){
        let movieListView = MovieListView()
        MovieListRouter.createMovieListModule(view: movieListView)
        
        XCTAssertNotNil(movieListView)
        XCTAssertNotNil(movieListView.presenter)
    }
}
