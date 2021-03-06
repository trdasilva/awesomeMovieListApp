//
//  ViewController.swift
//  AwesomeMovieListApp
//
//  Created by Tomaz Rocha Silva on 23/10/18.
//  Copyright © 2018 Tomaz Rocha Silva. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListView: UIViewController,MovieListPresenterToViewProtocol {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    var presenter : MovieListViewToPresenterProtocol? = nil
    let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Awesome Movie App"
        MovieListRouter.createMovieListModule(view: self)
        errorView.isHidden = true
        setupSearchBar()
        setupRefreshControl()
        presenter?.viewLoaded()
    }

    @IBAction func tapToRetry(_ sender: Any) {
        self.errorView.isHidden = true
        presenter?.prefetchMoreMovies()
    }
    
    func showErrorView(){
        self.errorView.isHidden = false
    }
    
    func stopRefreshing(){
        self.refreshControl.endRefreshing()
    }
    
    func updateTableView() {
        self.refreshControl.endRefreshing()
        self.loadingIndicator.isHidden = true
        self.errorView.isHidden = true
        self.tableView.reloadData()
    }
    
    private func setupRefreshControl(){
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        let colorAttribute = [NSAttributedString.Key.foregroundColor: UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0) ]
        let attributedString = NSAttributedString(string: "Refreshing movie list", attributes: colorAttribute)
        refreshControl.attributedTitle = attributedString
        refreshControl.addTarget(self, action: #selector(refreshList(_:)), for:.valueChanged)
    }
    
    @objc private func refreshList(_ sender: Any){
        presenter?.prefetchMoreMovies()
    }
    
    private func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
    }
    
    func isSearchBeingUsed() -> Bool {
        return (searchController.isActive &&
         !(searchController.searchBar.text?.isEmpty ?? true))
    }    
}

extension MovieListView: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: (presenter?.isPrefetchNeeded)!) {
            presenter?.prefetchMoreMovies()
        }
    }
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.movieSelected(rowNumber: indexPath.row)
    }
}

extension MovieListView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowForSecton(section: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

extension MovieListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let text = searchBar.text{
          presenter?.filterMovieList(searchText: text)
        }
    }
}

extension MovieListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            presenter?.filterMovieList(searchText: text)
        }
    }
}

