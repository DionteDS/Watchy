//
//  SearchViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/22/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let baseURLforSearch = "https://api.themoviedb.org/3/search/movie"
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    private var movies: [[String: Any]] = [[String: Any]]()
    
    // SearchBar Property
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for a movie"
        return searchBar
    }()
    
    // Search movie tableView
    private let searchMovieTableView: UITableView = {
        let tableView = UITableView()
        let nib = UINib(nibName: "SearchedCellTableViewCell", bundle: nil)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(nib, forCellReuseIdentifier: "searchedMovieCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchMovieTableView.delegate = self
        searchMovieTableView.dataSource = self
        
        searchMovieTableView.separatorStyle = .none
        
        setupLayout()
        setupNavBar()
    }
    
    // Setup the constraints
    private func setupLayout() {
        
        view.addSubview(searchBar)
        view.addSubview(searchMovieTableView)
        
        // Search Bar constraints
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        // TableView constraints
        searchMovieTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        searchMovieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchMovieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    // Setup the Nav Bar
    private func setupNavBar() {
        
        navigationItem.title = "Search"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // MARK: - Networking Calls
    
    private func searchQuery(movie: String) {
        
        let params: [String: String] = ["api_key": apikey, "language": "en-US", "query": movie, "page": "1"]
        fetchMovieData(url: baseURLforSearch, parameters: params)
    }
    
    private func fetchMovieData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseData = responseValue["results"] as! [[String: Any]]? {
                    self.movies = responseData
                    self.searchMovieTableView.reloadData()
                }
                
            } else {
                print(response.error!)
            }
            
        }
        
    }
}

// MARK: TableView Delegate and DataSource Methods

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedMovieCell", for: indexPath) as! SearchedCellTableViewCell
        
        cell.customDesign()

        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.layer.masksToBounds = true
        
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    

}

// MARK: - SearchBar Delegate And DataSource Methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery(movie: searchBar.text!)
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
}
