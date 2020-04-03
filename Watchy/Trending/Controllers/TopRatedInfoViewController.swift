//
//  TopRatedInfoViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/31/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TopRatedInfoViewController: UIViewController {

    //MARK: - Properties
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    var movieTitle = ""
    var movieReleaseDate = ""
    var movieURL = ""
    var ratingCount = 0.0
    var movieSummary = ""
    
    // Poster imageView
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // movie title label
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    // movie release date label
    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // star rating imageView
    let movieRating: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // summary textView
    let summary: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.showsHorizontalScrollIndicator = true
        return textView
    }()
    
    // stackView
    let stacks: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movieTitle
        movieReleaseDateLabel.text = movieReleaseDate
        summary.text = movieSummary

        setupLayout()
        setupNavBar()
        parseImageData()
        
    }
    
    //MARK: - Setup UI Layout
    
    // setup the constraints
    private func setupLayout() {
        
        view.addSubview(posterImage)
        view.addSubview(stacks)
        view.addSubview(summary)
        
        stacks.addArrangedSubview(movieTitleLabel)
        stacks.addArrangedSubview(movieReleaseDateLabel)
        stacks.addArrangedSubview(movieRating)
        
        posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        stacks.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5).isActive = true
        stacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        stacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        summary.topAnchor.constraint(equalTo: stacks.bottomAnchor, constant: 10).isActive = true
        summary.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        summary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        summary.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        
        
    }
    
    // Setup the nav bar
    private func setupNavBar() {
        
        navigationItem.title = movieTitle
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    
    // MARK: - Networking Calls
    
    // parse the image data
    private func parseImageData() {
        
        Alamofire.request(baseImageURL + movieURL).responseImage { (response) in
            
            if let image = response.result.value {
                let size = CGSize(width: 414, height: 448)
                let scaledImage = image.af_imageScaled(to: size)
                DispatchQueue.main.async {
                    self.posterImage.image = scaledImage
                }
            }
            
        }
        
        // Determine the star rating for each movie selected
        if ratingCount >= 9  && ratingCount <= 10 {
            movieRating.image = UIImage(named: "regular_5")
        } else if ratingCount >= 8 && ratingCount < 9 {
            movieRating.image = UIImage(named: "regular_4_half")
        } else if ratingCount >= 7 && ratingCount < 8 {
            movieRating.image = UIImage(named: "regular_4")
        } else if ratingCount >= 6 && ratingCount < 7 {
            movieRating.image = UIImage(named: "regular_3_half")
        } else if ratingCount >= 5 && ratingCount < 6 {
            movieRating.image = UIImage(named: "regular_3")
        } else if ratingCount >= 4 && ratingCount < 5 {
            movieRating.image = UIImage(named: "regular_2_half")
        } else if ratingCount >= 3 && ratingCount < 4 {
            movieRating.image = UIImage(named: "regular_2")
        } else if ratingCount >= 2 && ratingCount < 3 {
            movieRating.image = UIImage(named: "regular_1_half")
        } else if ratingCount >= 1 && ratingCount < 2 {
            movieRating.image = UIImage(named: "regular_1")
        } else {
            movieRating.image = UIImage(named: "regular_0")
        }
        
    }

}
