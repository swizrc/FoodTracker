//
//  DateTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/8/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class DateTableViewController: UITableViewController {
    
    
    var Dates: [DateData] = []
    let dateComponents = NSDateComponents()
    let currentRawDate = NSDate()
    let dateFormatter = DateFormatter()
    var currentDate = ""
    var userName: String = ""
    var Containing: Bool = false
    var DirectoryURL = DateData.DocumentsDirectory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Select a Date"
        let fileman = FileManager.default
        let URL1 = DirectoryURL.appendingPathComponent("FoodTracker")
        let URL2 = URL1.appendingPathComponent("Users")
        let URL3 = URL2.appendingPathComponent(userName)
        DirectoryURL = URL3
        if !fileman.fileExists(atPath: DirectoryURL.path){
            do{
                try fileman.createDirectory(atPath: DirectoryURL.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError{
                print("Error: \(error.localizedDescription)")
            }
        }
        
        if let loadedDates = loadDates(){
            Dates = loadedDates
        }
        dateFormatter.dateFormat = "EEE. dd MMMM, yyyy"
        currentDate = dateFormatter.string(from: currentRawDate as Date)
        
        for date in Dates{
            if date.date == currentDate{
                Containing = true
                break
            }
        }
        if (!Containing)
        {
            Dates.insert(DateData(date: currentDate, userName: userName), at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            saveDates()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DateTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!DateTableViewCell
        let date = Dates[indexPath.row].date
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
            saveDates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp_Date = Dates[fromIndexPath.row] //First item to move in array
        Dates.remove(at: fromIndexPath.row)
        Dates.insert(temp_Date, at: to.row)
        super.tableView.moveRow(at: fromIndexPath, to: to)
        saveDates()
    }
    

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let FoodTableViewController = segue.destination as? FoodTableViewController{
            let selectedDateCell = sender as? DateTableViewCell
            let indexPath = tableView.indexPath(for: selectedDateCell!)
            FoodTableViewController.userName = userName
            FoodTableViewController.Date = Dates[indexPath!.row].date
            saveDates()
        }
    }
    
    private func saveDates(){
        NSKeyedArchiver.archiveRootObject(Dates, toFile: DirectoryURL.appendingPathComponent("Dates").path)
    }
    
    private func loadDates() -> [DateData]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: DirectoryURL.appendingPathComponent("Dates").path) as? [DateData]
    }

}
