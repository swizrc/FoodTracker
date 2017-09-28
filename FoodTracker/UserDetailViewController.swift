//
//  UserDetailViewController.swift
//  FoodTracker
//
//  Created by Samuel Itschner on 9/13/17.
//  Copyright © 2017 Samuel Itschner. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    var sendingUser: UserIdentData = UserIdentData(user: "temp",userPic: nil)!
    var UserData = [UserIdentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        userImageView.isUserInteractionEnabled = true
        subView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self,action: #selector(selectImageFromPhotoAlbum))
        tapRecognizer.delegate = self
        userImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        var Unique:Bool = true
        for elem in UserData{
            if elem.user == userNameTextField.text{
                Unique = false
            }
        }
        if userNameTextField.text != "" && Unique == true{
            sendingUser.user = userNameTextField.text!
            sendingUser.userPic = userImageView.image
            self.performSegue(withIdentifier: "unwindToUserTable", sender: self)
        }
    }

    @IBAction func CancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func selectImageFromPhotoAlbum(sender: UITapGestureRecognizer? = nil) {
        userNameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }

    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        userImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
