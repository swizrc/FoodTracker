//
//  FoodIdentData.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/10/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit
class UserIdentData: NSObject, NSCoding{
    var user: String
    var userPic: UIImage?
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory,in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    init?(user:String,userPic:UIImage?){
        if user == ""{
            return nil
        }
        self.user = user
        self.userPic = userPic
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(user,forKey: "user")
        aCoder.encode(userPic,forKey: "userPic")
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let user = aDecoder.decodeObject(forKey: "user") as! String
        let userPic = aDecoder.decodeObject(forKey: "userPic") as? UIImage
        self.init(user: user,userPic: userPic)
    }
}
