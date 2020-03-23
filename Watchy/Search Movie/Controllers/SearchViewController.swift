//
//  SearchViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/22/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for a movie"
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        setupLayout()
        setupNavBar()
    }
    
    private func setupLayout() {
        
        view.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func setupNavBar() {
        
        navigationItem.title = "Search"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    
}
