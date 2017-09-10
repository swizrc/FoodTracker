//
//  Food.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/12/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class Food: NSObject, NSCoding{
    var name: String
    var photo: UIImage?
    var calories: Int
    var protein: Int
    var quantity: Int
    var serving_unit: String
    var serving_quantity: Int
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Foods")
    
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
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey:"name")
        aCoder.encode(photo, forKey:"photo")
        aCoder.encode(calories, forKey:"calories")
        aCoder.encode(protein, forKey:"protein")
        aCoder.encode(quantity, forKey:"quantity")
        aCoder.encode(serving_unit, forKey:"serving_unit")
        aCoder.encode(serving_quantity, forKey:"serving_quantity")
    }
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey:"name") as! String
        let photo = aDecoder.decodeObject(forKey:"photo") as! UIImage
        let serving_quantity = aDecoder.decodeInteger(forKey: "serving_quantity")
        let calories = aDecoder.decodeInteger(forKey: "calories")
        let protein = aDecoder.decodeInteger(forKey: "protein")
        let quantity = aDecoder.decodeInteger(forKey: "quantity")
        let serving_unit = aDecoder.decodeObject(forKey:"serving_unit") as! String
        self.init(name: name,photo: photo,calories: calories,protein:protein,quantity:quantity,serving_unit:serving_unit,serving_quantity:serving_quantity)
    }
}
