//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/12/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var servingunitLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var servingquantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
