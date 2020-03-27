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
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    private var movies: [[String: Any]] = [[String: Any]]()
    
    private let movieTrendingCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let nib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "movieCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! TrendingCollectionViewCell
        
        if movies.count > 0 {
            
            let eachMovie = movies[indexPath.row]
            let ratingCount = eachMovie["vote_average"] as? Double ?? 0.0
            
            
            if let imageURL = eachMovie["poster_path"] as? String {
                Alamofire.request(baseImageURL + imageURL).responseImage { (response) in
                    
                    if let image = response.result.value {
                        let size = CGSize(width: 180, height: 215)
                        let scaledImage = image.af_imageScaled(to: size)
                        DispatchQueue.main.async {
                            cell.moviePoster.setCornerRadius()
                            cell.moviePoster.image = scaledImage
                            cell.movieTitle.text = eachMovie["title"] as? String ?? ""
                            cell.releaseDate.text = eachMovie["release_date"] as? String ?? ""
                        }
                    }
                    
                }
            }
            
            // Determine the star rating for each movie selected
            if ratingCount >= 9  && ratingCount <= 10 {
                cell.ratingImg.image = UIImage(named: "regular_5")
            } else if ratingCount >= 8 && ratingCount < 9 {
                cell.ratingImg.image = UIImage(named: "regular_4_half")
            } else if ratingCount >= 7 && ratingCount < 8 {
                cell.ratingImg.image = UIImage(named: "regular_4")
            } else if ratingCount >= 6 && ratingCount < 7 {
                cell.ratingImg.image = UIImage(named: "regular_3_half")
            } else if ratingCount >= 5 && ratingCount < 6 {
                cell.ratingImg.image = UIImage(named: "regular_3")
            } else if ratingCount >= 4 && ratingCount < 5 {
                cell.ratingImg.image = UIImage(named: "regular_2_half")
            } else if ratingCount >= 3 && ratingCount < 4 {
                cell.ratingImg.image = UIImage(named: "regular_2")
            } else if ratingCount >= 2 && ratingCount < 3 {
                cell.ratingImg.image = UIImage(named: "regular_1_half")
            } else if ratingCount >= 1 && ratingCount < 2 {
                cell.ratingImg.image = UIImage(named: "regular_1")
            } else {
                cell.ratingImg.image = UIImage(named: "regular_0")
            }
            
        }
        
        return cell
        
    }
    
}
