//
//  DateTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/8/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class DateTableViewController: UITableViewController {
    
    var Dates: [String] = []
    let dateComponents = NSDateComponents()
    let currentRawDate = NSDate()
    let dateFormatter = DateFormatter()
    var currentDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Select a Date"
        dateFormatter.dateFormat = "EEE. dd MMMM, yyyy"
        currentDate = dateFormatter.string(from: currentRawDate as Date)
        if (Dates.isEmpty)
        {
            Dates.insert(currentDate, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
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
        return Dates.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //load Food array for this date and user
        //set next table's Food array equal to array from here
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DateTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!DateTableViewCell
        let date = Dates[indexPath.row]
        //Formatting
        cell.dateLabel.text = date

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Dates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp_Date = Dates[fromIndexPath.row] //First item to move in array
        Dates.remove(at: fromIndexPath.row)
        Dates.insert(temp_Date, at: to.row)
        super.tableView.moveRow(at: fromIndexPath, to: to)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
