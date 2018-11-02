//
//  ViewController.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 23/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListView: UITableViewController, PresenterToViewProtocol {

    var presenter : ViewToPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieListRouter.createMovieListModule(movieListView: self)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as! MovieListCell
        
        cell.movieName.text = presenter?.getMovieTitleForRow(rowNumber: indexPath.row)
        cell.movieGenre.text = presenter?.getMovieGenresForRow(rowNumber: indexPath.row)
        cell.releaseDate.text = presenter?.getMovieReleaseDateForRow(rowNumber: indexPath.row)
        cell.backdropImage.loadImage(imageUrl: presenter?.getMovieImageForRow(rowNumber: indexPath.row))
        
        return cell
    }
}

