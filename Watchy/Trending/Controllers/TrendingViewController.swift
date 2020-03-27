//
//  TrendingViewController.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var layout = UICollectionViewFlowLayout()
    
    private let movieTrendingCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let nib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "movieCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: 414).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .black
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTrendingCollection.delegate = self
        movieTrendingCollection.dataSource = self
        
        setupLayout()
        setFlowLayout()
        
    }
    
    // setup the constraints
    private func setupLayout() {
        
        view.addSubview(movieTrendingCollection)
        
        movieTrendingCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        movieTrendingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieTrendingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    
    // Setup the flow layout
    private func setFlowLayout() {
        
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        movieTrendingCollection.setCollectionViewLayout(layout, animated: true)
        
    }
    

}


// MARK: - CollectionView Delegate and DataSource Methods

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! TrendingCollectionViewCell
        
        cell.bgView.backgroundColor = .red
        
        return cell
        
    }
    
}
