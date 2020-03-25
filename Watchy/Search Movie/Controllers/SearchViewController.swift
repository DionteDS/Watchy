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

class SearchViewController: UIViewController {
    
    // Properties
    
    // SearchBar Property
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for a movie"
        return searchBar
    }()
    
    // Search movie tableView
    let searchMovieTableView: UITableView = {
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
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        searchMovieTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        searchMovieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchMovieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupNavBar() {
        
        navigationItem.title = "Search"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedMovieCell", for: indexPath) as! SearchedCellTableViewCell
        
        cell.customDesign()

        cell.title.text = "Testing"
        cell.releaseDate.text = "2020/07/16"

        return cell
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

extension SearchViewController: UISearchBarDelegate {
    
}
