//
//  ViewController.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var createButton: UIButton!
    
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        intialize()
    }
    
    func intialize() {
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        userViewModel.delegate = self
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.userRotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func userRotated() {
        
        if UIDevice.current.orientation.isLandscape {
            
            
        }
    }

    @IBAction func createPressed(_ sender: UIButton) {
        
        if userViewModel.isValid() {
            
            userViewModel.createUser()
        } else {
            
            self.showPopUp(with: userViewModel.description,identifier: "failure")
            userViewModel.clearDescription()
        }
    }
    
    func clearTextFields() {
        
        DispatchQueue.main.async {
            
            self.emailTextField.text = K.emptyString
            self.firstNameTextField.text = K.emptyString
            self.lastNameTextField.text = K.emptyString
        }
    }
}

extension UserViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        userViewModel.setTextData(textField.tag,textField.text)
    }
}

extension UserViewController : UserViewModelDelegate {
    
    func gotMessage(_ message: String) {
        
        self.showPopUp(with: message, identifier: "Success")
        self.userViewModel.clearUserData()
        self.clearTextFields()
        self.userViewModel.clearDescription()
    }
}

