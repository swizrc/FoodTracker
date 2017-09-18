//
//  FoodHistoryTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/20/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit


protocol ProtocolHistoryView{
    func Sending(valuesSent: Food?,action: String?)
}

class FoodHistoryTableViewController: UITableViewController {
    var FoodsH = [Food]()
    var delegate:ProtocolHistoryView?
    var Date: String = ""
    
    var Action: String = ""
    
    //Incoming action from FoodViewController
    /*
    func Results(valuesSent: Food?,action: String?) {
        for iter1 in FoodsH{
            if iter1.name == valuesSent?.name{
                Unique = false
            }
        Unique = true
        }
        if valuesSent != nil && action == "AddItem" && Unique == true{
            FoodsH.insert(valuesSent!, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        else if valuesSent != nil && action == "ShowDetail"
        {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            FoodsH[(selectedIndexPath?.row)!] = valuesSent!
            tableView.reloadRows(at: [selectedIndexPath!], with: .none)
        }
    }*/
    
    private func loadSampleFood(){
        
        let photo1 = UIImage(named: "chicken-breast")
        let photo2 = UIImage(named: "eggs-pan")
        
        guard let food1 = Food (name: "Chicken Breast",photo: photo1, calories: 86,protein: 16,quantity: 1, serving_unit: "Breast", serving_quantity: 1)
            else{
                fatalError("Unable to food1")
        }
        guard let food2 = Food (name: "Egg", photo:photo2, calories: 70, protein: 6, quantity: 3,serving_unit: "Egg", serving_quantity: 1)
            else{
                fatalError("Unable to food2")}
        FoodsH += [food1,food2]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "Remove"
        navigationItem.title = "Food History"
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
        return FoodsH.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodHistoryTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodHistoryTableViewCell else{
            fatalError("The deque cell failed")
        }
        
        let food = FoodsH[indexPath.row]
        cell.dateLabel.text = Date
        cell.nameLabel.text = food.name
        cell.photoImageView.image = food.photo
        cell.calorieLabel.text = String(food.calories)
        cell.proteinLabel.text = String(food.protein)
        cell.quantityLabel.text = "Quantity: x" + String(food.quantity)
        cell.servingquantityLabel.text = "Serving:   " + String(food.serving_quantity)
        cell.servingunitLabel.text = food.serving_unit
        
        return cell
    }
    //Outoing information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if Action == "AddItem" || Action == "ShowDetail"{//AddItem or ShowDetail
            let FoodViewController: FoodViewController = segue.destination as! FoodViewController
            let selectedMealCell = sender as? FoodHistoryTableViewCell
            let indexPath = tableView.indexPath(for: selectedMealCell!)
            let selectedFood = FoodsH[(indexPath?.row)!]
            FoodViewController.food = selectedFood
            if Action == "AddItem"{
                FoodViewController.ActionIdent = "AddItemFromHistory"}
            if Action == "ShowDetail"{
                FoodViewController.ActionIdent = "EditItemFromHistory"}
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            FoodsH.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    //Incoming Data
    
    //Don't think this will work since we are not ever unwinding to history?
    //Well, Swift will look for this unwind even when executed elsewhere, use this to implement the Uniqueness
    //functionality
    @IBAction func unwindToFoodView(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? FoodViewController, let food = sourceViewController.food{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                FoodsH[selectedIndexPath.row] = food
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                let newIndexpath = IndexPath(row: 0,section:0)
                FoodsH.append(food)
                tableView.insertRows(at: [newIndexpath], with: .automatic)
            }
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
