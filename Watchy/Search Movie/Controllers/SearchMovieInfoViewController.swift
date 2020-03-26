//
//  SearchMovieInfoViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class SearchMovieInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"

    
    // ImageView
    let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
    }
    
    // Setup the constraints
    private func setupLayout() {
        
        view.addSubview(moviePoster)
        
        
        moviePoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moviePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

}
