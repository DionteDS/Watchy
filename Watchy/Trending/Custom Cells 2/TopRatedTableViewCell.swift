//
//  TopRatedTableViewCell.swift
//  Watchy
//
//  Created by Dionte Silmon on 3/31/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratedPosterImg: UIImageView!
    @IBOutlet weak var ratedTitleLabel: UILabel!
    @IBOutlet weak var ratedReleaseDateLabel: UILabel!
    @IBOutlet weak var ratedRatingImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
