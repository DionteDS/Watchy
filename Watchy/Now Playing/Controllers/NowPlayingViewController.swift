//
//  NowPlayingViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/19/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    // Properties
    
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
        
        nowPlayingTable.tableFooterView = UIView.init(frame: .zero)
        nowPlayingTable.separatorStyle = .none
        
        setupLayout()

    }
    
    // Setup constraints
    private func setupLayout() {
        
        view.addSubview(nowPlayingTable)
        
        nowPlayingTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        nowPlayingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        nowPlayingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        nowPlayingTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }

}

// MARK: - TableView Delegate and DataSource Methods

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! CustomCellTableViewCell
        
        cell.customDesign()
        
        cell.title.text = "Testing..."
        cell.releaseDate.text = "07/22/90"
        
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
