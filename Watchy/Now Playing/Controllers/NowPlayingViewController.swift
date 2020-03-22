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
    
    var nowPlayingMovies: [[String: Any]] = [[String: Any]]()
    
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

    }
    
    // Setup constraints
    private func setupLayout() {
        
        view.addSubview(nowPlayingTable)
        
        nowPlayingTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        nowPlayingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        nowPlayingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        nowPlayingTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupQuery() {
        
        let params: [String: String] = ["api_key": apikey, "language": "en-US", "page": "1"]
        
        fetchNowPlayingData(url: baseURL, parameters: params)
    }
    
    private func fetchNowPlayingData(url: String, parameters: [String: String]) {
        
        Alamofire.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseData = responseValue["results"] as! [[String: Any]]? {
                    self.nowPlayingMovies = responseData
                    self.nowPlayingTable.reloadData()
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
        
        let eachMovie = nowPlayingMovies[indexPath.row]
        
        cell.title.text = (eachMovie["title"] as? String ?? "")
        cell.releaseDate.text = (eachMovie["release_date"] as? String ?? "")
        
        
        return cell
        
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
    
}
