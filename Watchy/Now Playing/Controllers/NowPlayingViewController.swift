//
//  NowPlayingViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/19/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class NowPlayingViewController: UIViewController {
    
    // Properties
    
    let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    var nowPlayingMovies: [[String: Any]] = [[String: Any]]()
    var row = 0
//    let apikey = "Place api key here"
    
    // Create the now playing tableView
    let nowPlayingTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "CustomCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowPlayingTable.delegate = self
        nowPlayingTable.dataSource = self
        
        nowPlayingTable.separatorStyle = .none
        
        setupLayout()
        setupQuery()
        setupNavBar()

    }
    
    
    // Setup constraints
    private func setupLayout() {
        
        view.addSubview(nowPlayingTable)
        
        nowPlayingTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        nowPlayingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        nowPlayingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        nowPlayingTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    // Setup the nav bar
    private func setupNavBar() {
        
        navigationItem.title = "Now Playing"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // MARK: - Network calls
    
    // set the query search
    private func setupQuery() {
        
        let params: [String: String] = ["api_key": apikey, "language": "en-US", "page": "1"]
        
        fetchNowPlayingData(url: baseURL, parameters: params)
    }
    
    // Fetch the data
    private func fetchNowPlayingData(url: String, parameters: [String: String]) {
        
        Alamofire.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseData = responseValue["results"] as! [[String: Any]]? {
                    self.nowPlayingMovies = responseData
                    DispatchQueue.main.async {
                        self.nowPlayingTable.reloadData()
                    }
                }
            } else {
                print("Error, \(response.error!)")
            }
            
        }
        
    }

}

// MARK: - TableView Delegate and DataSource Methods

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! CustomCellTableViewCell
        
        cell.customDesign()
        
        if nowPlayingMovies.count > 0 {
            
            // Grab each movie from the array
            let eachMovie = nowPlayingMovies[indexPath.row]
            
            let rating = (eachMovie["vote_average"] as? Double ?? 0.0)
            
            // Grab the image url for each movie
            if let imageURL = eachMovie["poster_path"] as? String {
                Alamofire.request(baseImageURL + imageURL).responseImage { (response) in
                    if let image = response.result.value {
                        let size = CGSize(width: 100, height: 120)
                        let scaledImage = image.af_imageScaled(to: size)
                        DispatchQueue.main.async {
                            // Update the labels and image on the main thread
                            cell.title.text = (eachMovie["title"] as? String ?? "")
                            cell.releaseDate.text = (eachMovie["release_date"] as? String ?? "")
                            cell.posterImg.image = scaledImage
                        }
                    }
                }
            }
            
            // 5 stars
//            10 - Masterpiece
//            9 - Amazing
            
            // 4.5 stars
//            8 - Great
            
            // 4 stars
//            7 - Good
            
            // 3.5 stars
//            6 - Decent
            
            // 3 stars
//            5 - Mediocre
            
            // 2.5 stars
//            4 - Bad
            
            // 2 stars
//            3 - Awful
            
            // 1.5 stars
//            2 - Terrible
            
            // 1 stars
//            1 - Catastrophe
            
            
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
        
        if let rowIndex = tableView.indexPathForSelectedRow?.row {
            row = rowIndex
        }
        
        performSegue(withIdentifier: "goToInfoVC", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        
        // if you do not set `shadowPath` you'll notice laggy scrolling
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToInfoVC" {
            let controller = segue.destination as! InfoViewController
            
            let movie = nowPlayingMovies[row]
            
            controller.movieTitle = movie["title"] as? String ?? ""
            controller.movieReleaseDate = movie["release_date"] as? String ?? ""
            controller.movieURL = movie["poster_path"] as? String ?? ""
            controller.movieSummary = movie["overview"] as? String ?? ""
            controller.ratingCount = movie["vote_average"] as? Double ?? 0.0
        }
        
    }
    
}
