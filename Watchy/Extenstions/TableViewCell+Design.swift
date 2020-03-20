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
        
        // Create the border of the cell
        let radius: CGFloat = 3
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
        
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 1, height: 1)
//        layer.shadowRadius = 5
//        layer.shadowOpacity = 1
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
//        layer.cornerRadius = radius
        
    }
    
}
