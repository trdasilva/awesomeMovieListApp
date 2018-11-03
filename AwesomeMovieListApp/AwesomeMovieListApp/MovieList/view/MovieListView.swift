//
//  ViewController.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 23/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListView: UITableViewController, UITableViewDataSourcePrefetching,MovieListPresenterToViewProtocol {

    var presenter : MovieListViewToPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieListRouter.createMovieListModule(view: self)
        presenter?.viewLoaded()
    }

    func updateTableView() {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowForSecton(section: section) ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getNumberOfSections() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.movieSelected(rowNumber: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: (presenter?.isPrefetchNeeded)!) {
            presenter?.prefetchMoreMovies()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(presenter?.isMovieDataAvailable(index: indexPath) ?? false){
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as! MovieListCell
            
            cell.movieName.text = presenter?.getMovieTitleForRow(rowNumber: indexPath.row)
            cell.movieGenre.text = presenter?.getMovieGenresForRow(rowNumber: indexPath.row)
            cell.releaseDate.text = presenter?.getMovieReleaseDateForRow(rowNumber: indexPath.row)
            
            if let url = presenter?.getMovieImageForRow(rowNumber: indexPath.row){
                cell.backdropImage.loadImage(imageUrl:url)
            }else{
                cell.backdropImage.image = Image.init(named: "no_image")
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingMovieListCell", for: indexPath) as! MovieListCell
            return cell
        }
    }
}
