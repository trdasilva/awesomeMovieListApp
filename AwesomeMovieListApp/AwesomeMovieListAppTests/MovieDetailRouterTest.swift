//
//  MovieDetailRouterTest.swift
//  AwesomeMovieListAppTests
//
//  Created by Tomaz Rocha Silva on 05/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AwesomeMovieListApp

class MockBundleMovieDetailRouter : MovieDetailRouter{
    override class var mainStoryboard: UIStoryboard {
        return  UIStoryboard(name: "Main", bundle: Bundle(for: MovieDetailView.self))
    }
}

class MovieDetailRouterTest :XCTestCase{
    let defaultJsonString = "{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"}"
    
    
    func testCreationOfMovieDetailModuleWithValidMovie(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        
        let movieDetail : MovieDetailView? = MockBundleMovieDetailRouter.createMovieDetailModule(movie: movie) as? MovieDetailView

        XCTAssertNotNil(movieDetail)
        XCTAssertEqual(movieDetail?.presenter?.getMovieTitle(), movie?.title)
    }
}
