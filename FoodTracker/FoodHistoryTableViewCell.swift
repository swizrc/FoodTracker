//
//  FoodHistoryTableViewCell.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/25/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class FoodHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var servingquantityLabel: UILabel!
    @IBOutlet weak var servingunitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
