//
//  InfoViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/22/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    // Properties
    
    var movieTitle = ""
    var movieReleaseDate = ""
    var ratingCount = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
        print(movieTitle)
        print(movieReleaseDate)
    }
    
    func setupNavBar() {
        
        navigationItem.title = movieTitle
        
        
    }
    
    

}
