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
    var ratingCount = 0.0
    var movieURL = ""
    var movieSummary = ""
    
    // poster image
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // title label
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    // release date label
    let movieRelease: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // rating label
    let movieRating: UIImageView = {
        let rating = UIImageView()
        rating.contentMode = .scaleAspectFit
        return rating
    }()
    
    // movie summary text view
    let summary: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17)
        text.isScrollEnabled = true
        text.isEditable = false
        text.showsHorizontalScrollIndicator = true
        text.showsVerticalScrollIndicator = true
        text.textColor = .black
        return text
    }()
    
    // UIstackView
    let stacks: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupLayout()
        fetchPoster()
        
        movieTitleLabel.text = movieTitle
        movieRelease.text = movieReleaseDate
        summary.text = movieSummary
        
    }
    
    // setup layout
    private func setupLayout() {
        
        view.addSubview(movieImage)
        view.addSubview(stacks)
        view.addSubview(summary)
        
        // Add the labels and imageView to the stackView
        stacks.addArrangedSubview(movieTitleLabel)
        stacks.addArrangedSubview(movieRelease)
        stacks.addArrangedSubview(movieRating)
        
        // constraints for movieImage
        movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        // constraints for stackView
        stacks.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5).isActive = true
        stacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        stacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        // onstraints for summary textView
        summary.topAnchor.constraint(equalTo: stacks.bottomAnchor, constant: 10).isActive = true
        summary.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        summary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        summary.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        
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
                    // Display movie image on main thread
                    self.movieImage.image = scaledImage
                }
            }
        }
        
        // Determine the star rating for each movie selected
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
}
