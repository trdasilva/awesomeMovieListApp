//
//  ViewController.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 23/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import UIKit

class MovieListView: UITableViewController {

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieRepository = MoviesRepository()
        movieRepository.getMovies().subscribe(
            onNext: {(movieList) in
                print(movieList)},
            onError: {(error) in print(error)},
            onCompleted: { print("finished") })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as! MovieListCell
        
        return cell
    }
}

