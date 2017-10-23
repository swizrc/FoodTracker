//
//  ViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 8/11/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit
import os.log

//Receiving
protocol  ProtocolFoodView {
    func Results(valuesSent: Food?,action: String?, Unique: Bool)
}

class FoodViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var imageJessMe: UIImageView!
    
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var servingquantityTextField: UITextField!
    @IBOutlet weak var servingunitTextField: UITextField!
    @IBOutlet weak var historySaveSwitch: UISwitch!
    
    func addDoneButtonOnNumpad(textField: UITextField){
        let keypadToolBar: UIToolbar = UIToolbar()
        
        keypadToolBar.items=[UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: textField,action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:self,action: nil)]
        keypadToolBar.sizeToFit()
        textField.inputAccessoryView = keypadToolBar
    }
    
    var food: Food?
    var delegate:ProtocolFoodView?
    var DefColor:UIColor?
    var ActionIdent:String?
    var FoodsH = [Food]()
    var Unique: Bool = true
    var AddToHist: Bool?
    var formattedDate: String = ""
    
    func HideHist(){
        switchLabel.isHidden = true
        historySaveSwitch.isHidden = true
    }
    
    //replace
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchLabel.isHidden = false
        historySaveSwitch.isHidden = false
        popupView.isHidden = true
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        if AddToHist == nil{
            AddToHist = true
        }
        // Handle the text field's user input through delegate callbacks
        historySaveSwitch.setOn(AddToHist!, animated: true)
        
        nameTextField.delegate = self
        calorieTextField.delegate = self
        proteinTextField.delegate = self
        quantityTextField.delegate = self
        servingquantityTextField.delegate = self
        servingunitTextField.delegate = self
        DefColor = saveButton.tintColor
        if ActionIdent == "AddItem"{
            saveButton.tintColor = UIColor.lightGray
            navigationItem.title = "Add a Food Item"}
        else if ActionIdent == "ShowDetail" || ActionIdent == "EditItemFromHistory"{
            navigationItem.title = "Edit Food Item"
            }
        else if ActionIdent == "ShowDetailHistory"{
            navigationItem.title = "Edit History Item"
            }
        else if ActionIdent == "AddItemFromHistory"{
            navigationItem.title = "Add from History"
            HideHist()
        }
        if food != nil{
            nameTextField.text = food!.name
            imageJessMe.image = food!.photo
            calorieTextField.text = String(food!.calories)
            proteinTextField.text = String(food!.protein)
            quantityTextField.text = String(food!.quantity)
            servingunitTextField.text = food!.serving_unit
            servingquantityTextField.text = String(food!.serving_quantity)
        }
        addDoneButtonOnNumpad(textField: calorieTextField)
        addDoneButtonOnNumpad(textField: proteinTextField)
        addDoneButtonOnNumpad(textField: quantityTextField)
        addDoneButtonOnNumpad(textField: servingquantityTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(nameTextField.text?.isEmpty)! && imageJessMe != nil && !(calorieTextField.text?.isEmpty)! && !(proteinTextField.text?.isEmpty)! && !(quantityTextField.text?.isEmpty)! && !(servingquantityTextField.text?.isEmpty)! && !(servingunitTextField.text?.isEmpty)!
        {
            saveButton.tintColor = DefColor
            
        }
        else
         {
            saveButton.tintColor = UIColor.lightGray
         }
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let FoodHistoryTableViewController = segue.destination as? FoodHistoryTableViewController
        if ActionIdent == "AddItem"{
            FoodHistoryTableViewController?.Action = ActionIdent!
            FoodHistoryTableViewController?.Date = formattedDate
        }
        if ActionIdent == "ShowDetail"{
            FoodHistoryTableViewController?.Action = ActionIdent!
            FoodHistoryTableViewController?.Date = formattedDate
        }
        FoodHistoryTableViewController?.FoodsH = FoodsH
    }
    
    //Photo Selection Handling
    @IBAction func selecImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageJessMe.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func HistSwitchPressed(_ sender: UISwitch) {
        if sender.isOn{
            AddToHist = true
        }
        else
        {
            AddToHist = false
        }
    }

    //DEPRECATED
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func Update(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {self.popupView.alpha = 0.0}, completion: nil)
    }

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
    
    //Outgoing info
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if !(nameTextField.text?.isEmpty)! && imageJessMe != nil && !(calorieTextField.text?.isEmpty)! && !(proteinTextField.text?.isEmpty)! && !(quantityTextField.text?.isEmpty)! && !(servingquantityTextField.text?.isEmpty)! && !(servingunitTextField.text?.isEmpty)!{
            let name = nameTextField.text ?? ""
            let photo = imageJessMe.image
            let calories = Int(calorieTextField.text!)
            let protein = Int(proteinTextField.text!)
            let quantity = Int(quantityTextField.text!)
            let serving_unit = servingunitTextField.text
            let serving_quantity = Int(servingquantityTextField.text!)
            
            food = Food(name: name,photo: photo,calories:calories!,protein:protein!, quantity: quantity!, serving_unit: serving_unit!, serving_quantity: serving_quantity!)
            
            for Food in FoodsH
            {
                if name.uppercased() == Food.name.uppercased() || !(AddToHist!)
                {
                    Unique = false
                    break
                }
            }
            if Unique == true{
                FoodsH.insert(food!, at: 0)
            }
            
            if ActionIdent == "AddItemFromHistory" || ActionIdent == "EditItemFromHistory"{
                self.performSegue(withIdentifier: "unwindToFoodList", sender: self)
            }
            if ActionIdent == "AddItem" || ActionIdent == "ShowDetail" && delegate != nil{
                delegate?.Results(valuesSent: food!,action: ActionIdent!, Unique: Unique)
            }
            if ActionIdent == "ShowDetail"
            {
                //From detail to table segue in case of edit action
                self.performSegue(withIdentifier: "DetailtoTable", sender: self)
            }
            Unique = true
            popupView.isHidden = false
            popupView.alpha = 1.0
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Update), userInfo: nil, repeats: false)
        }
    }
}
