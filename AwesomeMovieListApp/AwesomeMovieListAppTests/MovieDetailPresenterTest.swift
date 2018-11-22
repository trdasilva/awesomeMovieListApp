//
//  MovieDetailPresenterTest.swift
//  AwesomeMovieListAppTests
//
//  Created by Tomaz Rocha Silva on 03/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AwesomeMovieListApp

class MovieDetailPresenterTest: XCTestCase {
    
    let defaultJsonString = "{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"}"
    
    let defaultPosterUrl = URL(string: Config.posterImageBaseUrl
        + "/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg"
        + "?api_key="
        + Config.apiKey)
    
    let defaultBackdropUrl = URL(string: Config.backdropImageBaseUrl
        + "/jNUpYq2jRSwQM89vST9yQZelMSu.jpg"
        + "?api_key="
        + Config.apiKey)
    
    
    var presenter : MovieDetailPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = MovieDetailPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testGetMovieTitleWhenValidMovieTitle(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieTitle(),"Bohemian Rhapsody")
    }
    
    func testGetMovieTitleWhenNilMovieTitle(){
        let movie = Mapper<Movie>().map(JSONString: "{}")
        presenter.movieData = movie

        XCTAssertNil(presenter.getMovieTitle())
    }
    
    func testGetMovieTitleWhenNilMovieItem(){
        XCTAssertNil(presenter.getMovieTitle())
    }

    func testGetMovieGenreWhenValidMovieGenre(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        movie?.genres = "Action"
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieGenres(),"Action")
    }
    
    func testGetMovieGenreWhenNilMovieGenre(){
        let movie = Mapper<Movie>().map(JSONString: "{}")
        presenter.movieData = movie
        
        XCTAssertNil(presenter.getMovieGenres())
    }
    
    func testGetMovieGenreWhenNilMovieItem(){
        XCTAssertNil(presenter.getMovieGenres())
    }
    
    func testGetMovieReleaseDateWhenValidReleaseDate(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieReleaseDate(),"2018-10-24")
    }
    
    func testGetMovieReleaseDateWhenNilMovieReleaseDate(){
        let movie = Mapper<Movie>().map(JSONString: "{}")
        presenter.movieData = movie
        
        XCTAssertNil(presenter.getMovieReleaseDate())
    }
    
    func testGetMovieReleaseDateWhenNilMovieItem(){
        XCTAssertNil(presenter.getMovieReleaseDate())
    }
    
    func testGetMovieOverviewWhenValidOverview(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieOverview(),"Very short overview")
    }
    
    func testGetMovieOverviewWhenNilMovieOverview(){
        let movie = Mapper<Movie>().map(JSONString: "{}")
        presenter.movieData = movie
        
        XCTAssertNil(presenter.getMovieOverview())
    }
    
    func testGetMovieOverviewWhenNilMovieItem(){
        XCTAssertNil(presenter.getMovieOverview())
    }

    func testGetImageUrlWhenHasPosterAndbackdropImage(){
        let movie = Mapper<Movie>().map(JSONString: defaultJsonString)
        presenter.movieData = movie

        XCTAssertEqual(presenter.getMovieImage(),defaultBackdropUrl)
    }
    
    func testGetImageUrlWhenHasOnlyPosterImage(){
        
        let onlyPosterUrltJsonString = "{\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"}"
        
        let movie = Mapper<Movie>().map(JSONString: onlyPosterUrltJsonString)
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieImage(),defaultPosterUrl)
    }
    
    func testGetImageUrlWhenHasOnlyBackdropImage(){
        
        let onlyPosterUrltJsonString = "{\"title\": \"Bohemian Rhapsody\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"}"
        
        let movie = Mapper<Movie>().map(JSONString: onlyPosterUrltJsonString)
        presenter.movieData = movie
        
        XCTAssertEqual(presenter.getMovieImage(),defaultBackdropUrl)
    }
    
    func testGetImageUrlWhenNilMovieImageUrl(){
        let movie = Mapper<Movie>().map(JSONString: "{}")
        presenter.movieData = movie
        
        XCTAssertNil(presenter.getMovieImage())
    }
    
    func testGetMovieImageUrlWhenNilMovieItem(){
        XCTAssertNil(presenter.getMovieImage())
    }
}
