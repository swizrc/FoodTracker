//
//  Food.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/12/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class Food{
    var name: String
    var photo: UIImage?
    var calories: Int
    var protein: Int
    var quantity: Int
    var serving_unit: String
    var serving_quantity: Int
    
    
    init?(name:String,photo: UIImage?,calories:Int,protein:Int,quantity:Int,serving_unit:String,serving_quantity:Int) {
        if name.isEmpty || calories < 0 || protein < 0 || quantity < 0 || serving_unit == "" || serving_quantity < 0{
            return nil
        }
        self.name = name
        self.photo = photo
        self.calories = calories
        self.protein = protein
        self.quantity = quantity
        self.serving_unit = serving_unit
        self.serving_quantity = serving_quantity
    }
}
