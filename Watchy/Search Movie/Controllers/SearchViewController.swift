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
    
    // Setup the search query
    private func searchQuery(movie: String) {
        
        let params: [String: String] = ["api_key": apikey, "language": "en-US", "query": movie, "page": "1"]
        fetchMovieData(url: baseURLforSearch, parameters: params)
    }
    
    // Parse the data
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
        
        if movies.count > 0 {
            
            let movie = movies[indexPath.row]
            
            let rating = movie["vote_average"] as? Double ?? 0.0
            
            
            if let imageURL = movie["poster_path"] as? String {
                Alamofire.request(baseImageURL + imageURL).responseImage { (response) in
                    if let image = response.result.value {
                        let size = CGSize(width: 100, height: 120)
                        let scaledImage = image.af_imageScaled(to: size)
                        DispatchQueue.main.async {
                            cell.title.text = movie["title"] as? String ?? ""
                            cell.releaseDate.text = movie["release_date"] as? String ?? ""
                            cell.posterImage.image = scaledImage
                            // Put in github link to image
//                            <a target="_blank" href="https://icons8.com/icons/set/error">Error icon</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
                        }
                    }
                }
            }
            
            // Determine the star rating for each movie
            if rating >= 9  && rating <= 10{
                cell.ratingImg.image = UIImage(named: "regular_5")
            } else if rating >= 8 && rating < 9 {
                cell.ratingImg.image = UIImage(named: "regular_4_half")
            } else if rating >= 7 && rating < 8 {
                cell.ratingImg.image = UIImage(named: "regular_4")
            } else if rating >= 6 && rating < 7 {
                cell.ratingImg.image = UIImage(named: "regular_3_half")
            } else if rating >= 5 && rating < 6 {
                cell.ratingImg.image = UIImage(named: "regular_3")
            } else if rating >= 4 && rating < 5 {
                cell.ratingImg.image = UIImage(named: "regular_2_half")
            } else if rating >= 3 && rating < 4 {
                cell.ratingImg.image = UIImage(named: "regular_2")
            } else if rating >= 2 && rating < 3 {
                cell.ratingImg.image = UIImage(named: "regular_1_half")
            } else if rating >= 1 && rating < 2 {
                cell.ratingImg.image = UIImage(named: "regular_1")
            } else {
                cell.ratingImg.image = UIImage(named: "regular_0")
            }
            
        }

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
