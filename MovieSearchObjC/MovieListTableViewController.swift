//
//  MovieListTableViewController.swift
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [DMNMovie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.searchBar.resignFirstResponder()
        
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else { return }
        
        DMNMovieController.fetchMovie(withSearchTerm: searchTerm) { (movies) in
            guard let movies = movies else { return }
            self.movies = movies
        }
    }
}
