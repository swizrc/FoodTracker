//
//  FoodTableViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/12/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

//Sending

class FoodTableViewController: UITableViewController ,ProtocolFoodView{
    var Foods = [Food]()
    var FoodsH = [Food]()
    var CurrentState: String = ""
    
    
    
    //Incoming info from History table
    func Sending(valuesSent: Food?, action: String?) {
        
    }
    
    func Results(valuesSent: Food?,action: String?,Unique: Bool) {
        if valuesSent != nil && action == "AddItem" || action == "AddItemHistory"{
            Foods.insert(valuesSent!, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            if Unique == true{
                FoodsH.insert(valuesSent!, at: 0)
            }
        }
        else if valuesSent != nil && action == "ShowDetail"
        {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            Foods[(selectedIndexPath?.row)!] = valuesSent!
            tableView.reloadRows(at: [selectedIndexPath!], with: .none)
            if Unique == true{
                FoodsH.insert(valuesSent!, at: 0)
            }
        }
    }
    
    private func loadSampleFood(){
        let photo1 = UIImage(named: "chicken-breast")
        let photo2 = UIImage(named: "eggs-pan")
        
        guard let food1 = Food (name: "Chicken Breast",photo: photo1, calories: 86,protein: 16,quantity: 1, serving_unit: "Breast", serving_quantity: 1)
            else{
                fatalError("Unable to food1")
        }
        guard let food2 = Food (name: "Egg", photo:photo2, calories: 70, protein: 6, quantity: 3,serving_unit: "Egg", serving_quantity: 1)
            else{
                fatalError("Unable to food2")
        }
        Foods += [food1,food2]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.title = "Edit"
        loadSampleFood()
        navigationItem.title = "Main Food List"

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
        return Foods.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The deque cell failed")
        }
        
        let food = Foods[indexPath.row]
        cell.nameLabel.text = food.name
        cell.photoImageView.image = food.photo
        cell.calorieLabel.text = String(food.calories)
        cell.proteinLabel.text = String(food.protein)
        cell.quantityLabel.text = "Quantity: x" + String(food.quantity)
        cell.servingquantityLabel.text = "Serving:   " + String(food.serving_quantity)
        cell.servingunitLabel.text = food.serving_unit
        
        return cell
    }
    //Data Forward
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let FoodViewController: FoodViewController = segue.destination as! FoodViewController
            FoodViewController.delegate = self
            FoodViewController.ActionIdent = segue.identifier
            FoodViewController.FoodsH = FoodsH
        }
        else if segue.identifier == "ShowDetail"
        {
            let FoodDetailViewController = segue.destination as? FoodViewController
            FoodDetailViewController!.delegate = self
            let selectedMealCell = sender as? MealTableViewCell
            let indexPath = tableView.indexPath(for: selectedMealCell!)
            let selectedFood = Foods[(indexPath?.row)!]
            
            FoodDetailViewController!.food = selectedFood
            FoodDetailViewController!.ActionIdent = segue.identifier
            FoodDetailViewController?.FoodsH = FoodsH
        }
    }
    
    @IBAction func unwindToFoodList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? FoodViewController, let food = sourceViewController.food{
            let newIndexPath = IndexPath(row: 0, section: 0)
            if sourceViewController.ActionIdent == "AddItemFromHistory"{
                Foods.insert(food, at: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)}
            else if sourceViewController.ActionIdent == "EditItemFromHistory"{
                let selectedIndexPath = tableView.indexPathForSelectedRow
                Foods[(selectedIndexPath?.row)!] = food
                tableView.reloadRows(at: [selectedIndexPath!], with: .none)
            }
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
            Foods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp_Food = Foods[fromIndexPath.row] //First item to move in array
        Foods.remove(at: fromIndexPath.row)
        Foods.insert(temp_Food, at: to.row)
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
