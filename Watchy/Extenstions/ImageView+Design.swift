//
//  ImageView+Design.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setCornerRadius() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
    }
    
}
