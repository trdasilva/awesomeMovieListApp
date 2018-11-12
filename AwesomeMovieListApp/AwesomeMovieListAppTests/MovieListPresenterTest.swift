//
//  MovieListPresenterTest.swift
//  AwesomeMovieListAppTests
//
//  Created by Tomaz Rocha Silva on 11/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AwesomeMovieListApp

class MockIsSearchBeingUsed: MovieListView {
    override func isSearchBeingUsed() -> Bool {
        return true
    }
}

class MovieListPresenterTest: XCTestCase {
    let twoMoviesJSON = "[{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"},{\"id\": 426543,\"title\": \"The Nutcracker and the Four Realms\",\"poster_path\": \"/aRD1vLU7k5NHO0HThfHrjEQwWRz.jpg\",\"backdrop_path\": \"/l2ji4YiNSPBV69WjGBgU0gCvRqy.jpg\",\"overview\": \"Very short overview nutcracker\",\"release_date\": \"2018-10-26\"}]"
    
    var presenter : MovieListPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = MovieListPresenter()
        presenter.movieList = Mapper<Movie>().mapArray(JSONString: twoMoviesJSON)
        presenter.movieList?[0].genres = "Action, Romantic"
        presenter.movieList?[1].genres = "Thriller, Comedy"
    }
    
    func testIsPrefetchNeededWhenCurrentRowIs0AndListSizeIs2(){
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertFalse(presenter.isPrefetchNeeded(index: indexPath))
    }
    
    func testIsPrefetchNeededWhenCurrentRowIs1AndListSizeIs2(){
        let indexPath = IndexPath(row: 1, section: 0)
        XCTAssertFalse(presenter.isPrefetchNeeded(index: indexPath))
    }
    
    func testIsPrefetchNeededWhenCurrentRowIs2AndListSizeIs2(){
        let indexPath = IndexPath(row: 2, section: 0)
        XCTAssertTrue(presenter.isPrefetchNeeded(index: indexPath))
    }
    
    func testIsPrefetchNeededWhenCurrentRowIs0AndListIsNil(){
        presenter.movieList = nil
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(presenter.isPrefetchNeeded(index: indexPath))
    }
    
    func testIsMovieDataAvailableWhenCurrentRowIs0AndListSizeIs2(){
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(presenter.isMovieDataAvailable(index: indexPath))
    }
    
    func testIsMovieDataAvailableWhenCurrentRowIs1AndListSizeIs2(){
        let indexPath = IndexPath(row: 1, section: 0)
        XCTAssertTrue(presenter.isMovieDataAvailable(index: indexPath))
    }
    
    func testIsMovieDataAvailableWhenCurrentRowIs2AndListSizeIs2(){
        let indexPath = IndexPath(row: 2, section: 0)
        XCTAssertFalse(presenter.isMovieDataAvailable(index: indexPath))
    }
    
    func testIsMovieDataAvailableWhenCurrentRowIs2AndListIsNil(){
        presenter.movieList = nil
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertFalse(presenter.isMovieDataAvailable(index: indexPath))
    }
    
    func testFilterMovieListWithAValidMovieNameWhenListSize2(){
        let filterString = "Bohemian"
        
        presenter.filterMovieList(searchText: filterString)
        XCTAssertEqual(presenter.filteredMovieList?.count, 1)
        
        let filteredMovie = presenter.filteredMovieList?.first
        XCTAssertEqual(filteredMovie?.title, "Bohemian Rhapsody")
    }
    
    func testFilterMovieListWithAnInValidMovieNameWhenListSize2(){
        let filterString = "ert"
        
        presenter.filterMovieList(searchText: filterString)
        XCTAssertEqual(presenter.filteredMovieList?.count, 0)
    }
    
    func testFilterMovieListWithAValidMovieNameWhenListIsNil(){
        let filterString = "Bohemian"
        presenter.movieList = nil
        
        presenter.filterMovieList(searchText: filterString)
        XCTAssertEqual(presenter.filteredMovieList?.count, nil)
        
        let filteredMovie = presenter.filteredMovieList?.first
        XCTAssertEqual(filteredMovie?.title, nil)
    }
    
    func testFilterMovieListWithAnInValidMovieNameWhenListIsNil(){
        let filterString = "ert"
        presenter.movieList = nil
        presenter.filterMovieList(searchText: filterString)
        XCTAssertEqual(presenter.filteredMovieList?.count, nil)
    }
    
    func testNumberOfSections(){
        XCTAssertEqual(presenter.getNumberOfSections(), 1)
    }
    
    func testGetNumberOfRowsInSectionWithoutFilterEnabled(){
        presenter.totalMovies = 10
        presenter.filteredMovieList = presenter.movieList
        
        //shuold return the same value for every section
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 0), presenter.totalMovies)
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 1), presenter.totalMovies)
    }
    
    func testGetNumberOfRowsInSectionWithFilterEnabled(){
        presenter.totalMovies = 10
        presenter.filteredMovieList = presenter.movieList
        presenter.view = MockIsSearchBeingUsed()
        
        //shuold return the same value for every section
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 0), presenter.filteredMovieList?.count)
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 1), presenter.filteredMovieList?.count)
    }
    
    func testGetNumberOfRowsInSectionWithFilterEnabledAndFilteredListNil(){
        presenter.totalMovies = 10
        presenter.filteredMovieList = nil
        presenter.view = MockIsSearchBeingUsed()
        
        //shuold return the same value for every section
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 0), 0)
        XCTAssertEqual(presenter.getNumberOfRowForSecton(section: 1), 0)
    }
    
    func testGetTitleForRow(){
        XCTAssertEqual(presenter.getMovieTitleForRow(rowNumber: 0), "Bohemian Rhapsody")
        XCTAssertEqual(presenter.getMovieTitleForRow(rowNumber: 1), "The Nutcracker and the Four Realms")
    }
    
    func testGetTitleForRowWithFilterEnabled(){
        let filterString = "Nutcracker"
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        
        XCTAssertEqual(presenter.getMovieTitleForRow(rowNumber: 0), "The Nutcracker and the Four Realms")
    }
    
    func testGetGenresForRow(){
        XCTAssertEqual(presenter.getMovieGenresForRow(rowNumber: 0), "Action, Romantic")
        XCTAssertEqual(presenter.getMovieGenresForRow(rowNumber: 1), "Thriller, Comedy")
    }
    
    func testGetGenresForRowWithFilterEnabled(){
        let filterString = "Nutcracker"
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        
        XCTAssertEqual(presenter.getMovieGenresForRow(rowNumber: 0), "Thriller, Comedy")
    }
    
    func testGetReleaseDateForRow(){
        XCTAssertEqual(presenter.getMovieReleaseDateForRow(rowNumber: 0), "2018-10-24")
        XCTAssertEqual(presenter.getMovieReleaseDateForRow(rowNumber: 1), "2018-10-26")
    }
    
    func testGetReleaseDateForRowWithFilterEnabled(){
        let filterString = "Nutcracker"
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        
        XCTAssertEqual(presenter.getMovieReleaseDateForRow(rowNumber: 0), "2018-10-26")
    }
    
    func testGetImageForRowWhenHasPosterAndBackdropImage(){
        
        let defaultBackdropUrl = URL(string: Config.backdropImageBaseUrl
            + "/jNUpYq2jRSwQM89vST9yQZelMSu.jpg"
            + "?api_key="
            + Config.apiKey)
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultBackdropUrl)
    }
    
    func testGetImageForRowWhenHasPosterAndBackdropImageWithFilterEnabled(){
        let defaultBackdropUrl = URL(string: Config.backdropImageBaseUrl
            + "/l2ji4YiNSPBV69WjGBgU0gCvRqy.jpg"
            + "?api_key="
            + Config.apiKey)
        
        let filterString = "Nutcracker"
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultBackdropUrl)
    }
    
    func testGetImageForRowWhenHasOnlyPosterImage(){
        let twoMoviesOnlyPosterImageJSON = "[{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"},{\"id\": 426543,\"title\": \"The Nutcracker and the Four Realms\",\"poster_path\": \"/aRD1vLU7k5NHO0HThfHrjEQwWRz.jpg\",\"overview\": \"Very short overview nutcracker\",\"release_date\": \"2018-10-26\"}]"
        presenter.movieList = Mapper<Movie>().mapArray(JSONString: twoMoviesOnlyPosterImageJSON)
        
        let defaultPosterUrl = URL(string: Config.posterImageBaseUrl
            + "/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg"
            + "?api_key="
            + Config.apiKey)
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultPosterUrl)
    }
    
    func testGetImageForRowWhenHasOnlyPosterImageWithFilterEnabled(){
        let twoMoviesOnlyPosterImageJSON = "[{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"poster_path\": \"/jf7jiy0rDVn1ljUwv3pWKousQ1p.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"},{\"id\": 426543,\"title\": \"The Nutcracker and the Four Realms\",\"poster_path\": \"/aRD1vLU7k5NHO0HThfHrjEQwWRz.jpg\",\"overview\": \"Very short overview nutcracker\",\"release_date\": \"2018-10-26\"}]"
        presenter.movieList = Mapper<Movie>().mapArray(JSONString: twoMoviesOnlyPosterImageJSON)
        
        let filterString = "Nutcracker"
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        let defaultPosterUrl = URL(string: Config.posterImageBaseUrl
            + "/aRD1vLU7k5NHO0HThfHrjEQwWRz.jpg"
            + "?api_key="
            + Config.apiKey)
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultPosterUrl)
    }
    
    func testGetImageForRowWhenHasOnlyBackdropImage(){
        let twoMoviesOnlyBacdropImageJSON = "[{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"},{\"id\": 426543,\"title\": \"The Nutcracker and the Four Realms\",\"backdrop_path\": \"/l2ji4YiNSPBV69WjGBgU0gCvRqy.jpg\",\"overview\": \"Very short overview nutcracker\",\"release_date\": \"2018-10-26\"}]"
        
        presenter.movieList = Mapper<Movie>().mapArray(JSONString: twoMoviesOnlyBacdropImageJSON)
        
        let defaultBackdropUrl = URL(string: Config.backdropImageBaseUrl
            + "/jNUpYq2jRSwQM89vST9yQZelMSu.jpg"
            + "?api_key="
            + Config.apiKey)
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultBackdropUrl)
    }
    
    func testGetImageForRowWhenHasOnlyBackdropImageWithFilterEnabled(){
        let filterString = "Nutcracker"
        
        let twoMoviesOnlyBacdropImageJSON = "[{\"id\": 424694,\"title\": \"Bohemian Rhapsody\",\"backdrop_path\": \"/jNUpYq2jRSwQM89vST9yQZelMSu.jpg\",\"overview\": \"Very short overview\",\"release_date\": \"2018-10-24\"},{\"id\": 426543,\"title\": \"The Nutcracker and the Four Realms\",\"backdrop_path\": \"/l2ji4YiNSPBV69WjGBgU0gCvRqy.jpg\",\"overview\": \"Very short overview nutcracker\",\"release_date\": \"2018-10-26\"}]"
        
        presenter.movieList = Mapper<Movie>().mapArray(JSONString: twoMoviesOnlyBacdropImageJSON)
        presenter.filterMovieList(searchText: filterString)
        presenter.view = MockIsSearchBeingUsed()
        
        let defaultBackdropUrl = URL(string: Config.backdropImageBaseUrl
            + "/l2ji4YiNSPBV69WjGBgU0gCvRqy.jpg"
            + "?api_key="
            + Config.apiKey)
        
        XCTAssertEqual(presenter.getMovieImageForRow(rowNumber: 0), defaultBackdropUrl)
    }
}
