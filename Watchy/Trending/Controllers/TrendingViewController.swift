//
//  TrendingViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class TrendingViewController: UIViewController {
    
//    <a target="_blank" href="https://icons8.com/icons/set/poll-topic--v1">Poll icon</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a> put link in github for the icon 
    
    // MARK: - Properties
    
    private var layout = UICollectionViewFlowLayout()
    private let trendingBaseURL = "https://api.themoviedb.org/3/trending/movie/week"
    private var movies: [[String: Any]] = [[String: Any]]()
    
    private let movieTrendingCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let nib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "movieCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .black
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTrendingCollection.delegate = self
        movieTrendingCollection.dataSource = self
        
        setupLayout()
        setupNavBar()
        setFlowLayout()
        
        setQuery()
        
    }
    
    // MARK: Setup the UI
    
    private func setupNavBar() {
        
        navigationItem.title = "Trending this week"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
    }
    
    // setup the constraints
    private func setupLayout() {
        
        view.addSubview(movieTrendingCollection)
        
        movieTrendingCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        movieTrendingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieTrendingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    
    // setup flow layout
    private func setFlowLayout() {
        
        layout.itemSize = CGSize(width: 180, height: 290)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        movieTrendingCollection.setCollectionViewLayout(layout, animated: true)
        
    }
    
    
    // MARK: - Networking Calls
    
    private func setQuery() {
        
        let params: [String: String] = ["api_key": apikey]
        
        fetchData(url: trendingBaseURL, parameters: params)
        
    }
    
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseData = responseValue["results"] as! [[String: Any]]? {
                    self.movies = responseData
                    self.movieTrendingCollection.reloadData()
                }
            }
            
        }
        
    }
    

}


// MARK: - CollectionView Delegate and DataSource Methods

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! TrendingCollectionViewCell
        
        cell.movieTitle.text = "title"
        cell.releaseDate.text = "01/02/20"
        cell.moviePoster.backgroundColor = .cyan
        
        cell.movieTitle.textColor = .white
        cell.releaseDate.textColor = .white
        return cell
        
    }
    
}
