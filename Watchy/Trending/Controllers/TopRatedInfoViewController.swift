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
    
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 448).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let movieRating: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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

        setupLayout()
        setupNavBar()
        
    }
    
    //MARK: - Setup UI Layout
    
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
        
        
    }
    
    private func setupNavBar() {
        
        navigationItem.title = movieTitle
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    

}
