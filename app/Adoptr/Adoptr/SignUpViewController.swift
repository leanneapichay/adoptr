//
//  AdoptingSignUpViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 23/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
    
    
    var date: String = ""
    
    @IBOutlet weak var FirstNameField: UITextField?
    @IBOutlet weak var LastNameField: UITextField?
    @IBOutlet weak var BdayPicker: UIDatePicker?
    @IBOutlet weak var EmailField: UITextField?
    @IBOutlet weak var ZipCodeField: UITextField?
    @IBOutlet weak var PasswordField: UITextField?
    @IBOutlet weak var ConfirmPWField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BdayPicker?.setValue(UIColor.white, forKey: "textColor")
        self.hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, YYYY"
        date = dateFormatter.string(from: sender.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func NextButton(_ sender: Any) {
        let firstName = FirstNameField?.text
        let lastName = LastNameField?.text
        let birthdate = date
        let email = EmailField?.text
        var password: String?
        if(firstName == "" || lastName == "" || email == "" || password == "" || ConfirmPWField?.text == "" ){
            createAlert(title: "Error", message: "Please fill in all fields")
        }
        else{
            if(PasswordField?.text == ConfirmPWField?.text){
            password = PasswordField?.text
            /*
            let data : [String : String ] = ["firstName": firstName!, "lastName" : lastName!, "birthdate" : birthdate8, "email" : email!, "password" : password!]
                
            var acct: Acct = Acct(data)
            */
            performSegue(withIdentifier: "goToSplit", sender: self)
            }
            else{
                createAlert(title: "Error", message: "Passwords do not match.")
            }
        }
        
       
    
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //creating a button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
