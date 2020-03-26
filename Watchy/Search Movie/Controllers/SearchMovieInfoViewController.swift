//
//  SearchMovieInfoViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchMovieInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    var movieTitle = ""
    var movieRelease = ""
    var movieImageURL = ""
    var summary = ""
    var ratingCount = 0.0
    

    
    // ImageView
    let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        return imageView
    }()
    
    let searchedMovieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    let searchMovieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchMovieSummary: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.showsHorizontalScrollIndicator = true
        return textView
    }()
    
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

        setupLayout()
        setupNavBar()
        fetchData()
        
    }
    
    // setup the nav bar
    private func setupNavBar() {
        
        searchedMovieTitleLabel.text = movieTitle
        searchMovieReleaseDateLabel.text = movieRelease
        searchMovieSummary.text = summary
        
        
        navigationItem.title = movieTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // Setup the constraints
    private func setupLayout() {
        
        view.addSubview(moviePoster)
        view.addSubview(stacks)
        view.addSubview(searchMovieSummary)
        
        // Add labels and image to stackView
        stacks.addArrangedSubview(searchedMovieTitleLabel)
        stacks.addArrangedSubview(searchMovieReleaseDateLabel)
        stacks.addArrangedSubview(ratingImage)
        
        // constraint for moviePoster
        moviePoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        moviePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        // constraint for stackView
        stacks.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 5).isActive = true
        stacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        stacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        // constraint for summary
        searchMovieSummary.topAnchor.constraint(equalTo: stacks.bottomAnchor, constant: 10).isActive = true
        searchMovieSummary.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        searchMovieSummary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        searchMovieSummary.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        
        
    }
    
    // MARK: - Networking calls
    
    // Fetch the search movie data
    private func fetchData() {
        
        Alamofire.request(baseImageURL + movieImageURL).responseImage { (response) in
            if let image = response.result.value {
                let size = CGSize(width: 414, height: 448)
                let scaledImage = image.af_imageScaled(to: size)
                DispatchQueue.main.async {
                    self.moviePoster.image = scaledImage
                }
            }
        }
        
        // Determine the star rating for each movie selected
        if ratingCount >= 9  && ratingCount <= 10 {
            ratingImage.image = UIImage(named: "regular_5")
        } else if ratingCount >= 8 && ratingCount < 9 {
            ratingImage.image = UIImage(named: "regular_4_half")
        } else if ratingCount >= 7 && ratingCount < 8 {
            ratingImage.image = UIImage(named: "regular_4")
        } else if ratingCount >= 6 && ratingCount < 7 {
            ratingImage.image = UIImage(named: "regular_3_half")
        } else if ratingCount >= 5 && ratingCount < 6 {
            ratingImage.image = UIImage(named: "regular_3")
        } else if ratingCount >= 4 && ratingCount < 5 {
            ratingImage.image = UIImage(named: "regular_2_half")
        } else if ratingCount >= 3 && ratingCount < 4 {
            ratingImage.image = UIImage(named: "regular_2")
        } else if ratingCount >= 2 && ratingCount < 3 {
            ratingImage.image = UIImage(named: "regular_1_half")
        } else if ratingCount >= 1 && ratingCount < 2 {
            ratingImage.image = UIImage(named: "regular_1")
        } else {
            ratingImage.image = UIImage(named: "regular_0")
        }
        
    }

}
