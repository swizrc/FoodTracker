//
//  UserTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/9/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var UserData = [UserIdentData:[DateData]]()
    var order = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Select a User"
        loadSampleUser()
    }
    
    private func loadSampleUser(){
        let user1 = UserIdentData(user: "Xess",userPic: #imageLiteral(resourceName: "defaultPhoto"))
        let user2 = UserIdentData(user: "Sam",userPic: #imageLiteral(resourceName: "eggs-pan"))
        UserData[user1!] = [DateData(date:"")]
        UserData[user2!] = [DateData(date:"1")]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserData.count
    }
    
    private func orderKeys(){
        if order.isEmpty
        {
        for user in UserData.keys{
            order.append(user.user)
            }
        }
        order.sort()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "UserTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as! UserTableViewCell
        orderKeys()
        let key = findKeyObject(UserData: UserData, indexPath: indexPath)
        cell.userNameLabel.text = key.user
        cell.userImageView.image = key.userPic
        
        return cell
    }
    
    private func findKeyObject(UserData: [UserIdentData:[DateData]],indexPath: IndexPath) -> UserIdentData
    {
        var key: UserIdentData? = UserIdentData(user:"",userPic:nil)
        for user in UserData.keys
        {
            if user.user == order[indexPath.row]
            {
                key = user
            }
        }
        return key!
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
            if editingStyle == .delete
            {
                let key = findKeyObject(UserData: UserData, indexPath: indexPath)
                UserData.removeValue(forKey: key)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
