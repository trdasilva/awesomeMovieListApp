//
//  MovieDetailPresenter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 02/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation

class MovieDetailPresenter {
    
    var movieData: Movie?
    
    init(movie: Movie?){
        self.movieData = movie
    }
    
    func getMovieTitle() -> String?{
        return movieData?.title
    }
    
    func getMovieGenres() -> String?{
        return movieData?.genres
    }
    
    func getMovieImage() ->URL?{
        return movieData?.backdropImageUrl
    }
    
    func getMovieReleaseDate() -> String?{
        return movieData?.releaseDate
    }
    
    func getMovieOverview() -> String?{
        return movieData?.overview
    }
}
