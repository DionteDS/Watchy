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
    var row = 0
    
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
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trending Movies This Week"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    let topRatedHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        label.text = "Top Rated Movies"
        return label
    }()
    
    let topRatedTableView: UITableView = {
        let tableView = UITableView()
        let nib = UINib(nibName: "TopRatedTableViewCell", bundle: nil)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(nib, forCellReuseIdentifier: "topRatedCell")
        tableView.backgroundColor = .red
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTrendingCollection.delegate = self
        movieTrendingCollection.dataSource = self
        
        topRatedTableView.delegate = self
        topRatedTableView.dataSource = self
        
        setupLayout()
        setupNavBar()
        setFlowLayout()
        
        setQuery()
        
    }
    
    // MARK: Setup the UI
    
    private func setupNavBar() {
        
        navigationItem.title = "Trending"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
    }
    
    // setup the constraints
    private func setupLayout() {
        
        view.addSubview(headerTitle)
        view.addSubview(movieTrendingCollection)
        view.addSubview(topRatedHeader)
        view.addSubview(topRatedTableView)
        
        headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        movieTrendingCollection.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 10).isActive = true
        movieTrendingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieTrendingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        topRatedHeader.topAnchor.constraint(equalTo: movieTrendingCollection.bottomAnchor, constant: 10).isActive = true
        topRatedHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        topRatedHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true


        topRatedTableView.topAnchor.constraint(equalTo: topRatedHeader.bottomAnchor, constant: 10).isActive = true
        topRatedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topRatedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topRatedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
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
    
    // Set the query
    private func setQuery() {
        
        let params: [String: String] = ["api_key": apikey]
        
        fetchData(url: trendingBaseURL, parameters: params)
        
    }
    
    // parse movie data
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Grab the selected indexPath.row and store the index in row
        if let rowIndex = collectionView.indexPathsForSelectedItems?.first {
            row = rowIndex.row
        }
        
        performSegue(withIdentifier: "trendingSelectedInfo", sender: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "trendingSelectedInfo" {
            let controller = segue.destination as! TrendingSelectedInfoViewController
            let movie = movies[row]
            controller.movieTitle = movie["title"] as? String ?? ""
            controller.movieRelease = movie["release_date"] as? String ?? ""
            controller.movieURL = movie["poster_path"] as? String ?? ""
            controller.ratingCount = movie["vote_average"] as? Double ?? 0.0
            controller.movieSummary = movie["overview"] as? String ?? ""
        }
    }
    
}


// MARK: - TableView delegate and DataSource Methods


extension TrendingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "topRatedCell", for: indexPath) as! TopRatedTableViewCell

        cell.customDesign()


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
