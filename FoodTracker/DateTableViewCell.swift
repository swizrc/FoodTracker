//
//  DateTableViewCell.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/8/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
