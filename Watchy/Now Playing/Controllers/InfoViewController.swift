//
//  InfoViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/22/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class InfoViewController: UIViewController {
    
    // Properties
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    var movieTitle = ""
    var movieReleaseDate = ""
    var ratingCount = ""
    var movieURL = ""
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupLayout()
        fetchPoster()
        
    }
    
    private func setupLayout() {
        
        view.addSubview(movieImage)
        
        movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    
    // setup the Nav Bar
    private func setupNavBar() {
        navigationItem.title = movieTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Network Calls
    
    // Grab the selected movie poster image
    private func fetchPoster() {
        
        Alamofire.request(baseImageURL + movieURL).responseImage { (response) in
            if let image = response.result.value {
                let size = CGSize(width: 414, height: 448)
                let scaledImage = image.af_imageScaled(to: size)
                DispatchQueue.main.async {
                    self.movieImage.image = scaledImage
                }
            }
        }
        
    }
}
