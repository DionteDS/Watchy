//
//  CustomCellTableViewCell.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/20/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var ratingImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
