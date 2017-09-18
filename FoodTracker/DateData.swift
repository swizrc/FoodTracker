//
//  DateData.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/10/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit
class DateData: NSObject, NSCoding{
    var date: String
    let dateComponents = NSDateComponents()
    let currentRawDate = NSDate()
    let dateFormatter = DateFormatter()
    var currentDate = ""
    var userName: String = ""
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init(date: String, userName: String){
        dateFormatter.dateFormat = "EEE. dd MMMM, yyyy"
        if date == ""{
            currentDate = dateFormatter.string(from: currentRawDate as Date)
        }
        self.date = date
        self.userName = userName
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(userName, forKey: "userName")
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let date = aDecoder.decodeObject(forKey: "date") as! String
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.init(date: date, userName: userName)
    }
}
