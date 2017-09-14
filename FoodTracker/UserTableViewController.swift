//
//  UserTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/9/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var UserData = [UserIdentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Select a User"
        loadSampleUser()
        SortUsers()
    }
    
    private func loadSampleUser(){
        let user1 = UserIdentData(user: "Xess",userPic: #imageLiteral(resourceName: "defaultPhoto"))
        let user2 = UserIdentData(user: "Pam",userPic: #imageLiteral(resourceName: "eggs-pan"))
        let user3 = UserIdentData(user: "Jess",userPic: #imageLiteral(resourceName: "defaultPhoto"))
        let user4 = UserIdentData(user: "Sam",userPic: #imageLiteral(resourceName: "eggs-pan"))
        UserData.append(user1!)
        UserData.append(user2!)
        UserData.append(user3!)
        UserData.append(user4!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "UserTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as! UserTableViewCell
        let Found = UserData[indexPath.row]
        
        cell.userNameLabel.text = Found.user
        cell.userImageView.image = Found.userPic
        
        return cell
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
                UserData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    private func SortUsers(){
        for elem in UserData{
            elem.user = elem.user.capitalized
        }
        UserData = UserData.sorted(by: {$0.user < $1.user})
    }
    
    @IBAction func unwindToUserTable (sender: UIStoryboardSegue){
        let UserDetailViewController = sender.source as! UserDetailViewController
        let newUser = UserDetailViewController.sendingUser
        UserData.append(newUser)
        SortUsers()
        let newIndex = UserData.index(of: newUser)
        
        
        tableView.insertRows(at: [IndexPath(row:newIndex!,section:0)], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp_User = UserData[fromIndexPath.row] //First item to move in array
        UserData.remove(at: fromIndexPath.row)
        UserData.insert(temp_User, at: to.row)
        super.tableView.moveRow(at: fromIndexPath, to: to)
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let newViewController = segue.destination as? UserDetailViewController{
            newViewController.UserData = UserData
        }
        // Pass the selected object to the new view controller.
    }
    

}
