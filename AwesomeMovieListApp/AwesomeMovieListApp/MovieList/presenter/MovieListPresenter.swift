//
//  MovieListPresenter.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 01/11/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListPresenter : ViewToPresenterProtocol {
    
    var intereactor : PresenterToInteractorProtocol?
    var view: PresenterToViewProtocol?
    let disposeBag = DisposeBag()
    var  movieList : [Movie]? = nil
    
    func viewLoaded() {
        intereactor?.getMoviesList().subscribe(
            onNext: { movies in
                self.movieList = movies
        },
            onError: { error in
                print("An error occurred :" + error.localizedDescription)
        },
            onCompleted: {
                self.view?.updateTableView()
        }
        ).disposed(by: disposeBag)
    }
    
    func getNumberOfRowForSecton(section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func getNumberOfSections() -> Int{
        return 1
    }
    
    func getMovieTitleForRow(rowNumber: Int) -> String?{
        return movieList?[rowNumber].title
    }
    
    func getMovieGenresForRow(rowNumber: Int) -> String?{
        return movieList?[rowNumber].genres
    }
    
    func getMovieImageForRow(rowNumber: Int) ->URL?{
        return movieList?[rowNumber].backdropImageUrl
    }
    
    func getMovieReleaseDateForRow(rowNumber: Int) -> String?{
        return movieList?[rowNumber].releaseDate
    }
}
