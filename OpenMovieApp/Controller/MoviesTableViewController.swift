//
//  MoviesTableViewController.swift
//  OpenMovieApp
//
//  Created by Nan Su on 1/1/20.
//  Copyright © 2020 Nan Su. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var moviesManager = MoviesManager()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesManager.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        self.navigationItem.searchController = searchController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesManager.movieCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movie = moviesManager.getMovie(at: indexPath.row)
        if (movie != nil) {
            cell.textLabel?.text = movie?.title
            cell.detailTextLabel?.text = movie?.year
            cell.imageView?.image = movie?.poster
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            let viewController = segue.destination as? MovieDetailViewController {
            viewController.movie = moviesManager.getMovie(at: selectedIndexPath.row)
        }
    }

}

extension MoviesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        moviesManager.searchFilter = searchText
    }
}

extension MoviesTableViewController:MoviesManagerDelegate {
    func fetched() {
        tableView.reloadData()
    }
}
