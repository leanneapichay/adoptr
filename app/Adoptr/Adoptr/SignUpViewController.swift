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
    
    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var BdayPicker: UIDatePicker!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var ZipCodeField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmPWField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BdayPicker.setValue(UIColor.white, forKey: "textColor")
        
        
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
        let firstName = FirstNameField.text
        let lastName = LastNameField.text
        let birthdate = date
        let email = EmailField.text
        var password: String?
        if(PasswordField.text == ConfirmPWField.text){
            password = PasswordField.text
        }
        else{
            //insert error message
        }
        
        var data : [String : String ] = ["firstName": firstName!, "lastName" : lastName!, "birthdate" : birthdate, "email" : email!, "password" : password!]
        
        var acct: Acct = Acct(data)
    
    }

}
