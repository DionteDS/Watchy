//
//  TableViewCell+Design.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/20/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func customDesign() {
        
        // Add shadow on cell
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        // Add corner radius on contentView
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
    }
    
}
