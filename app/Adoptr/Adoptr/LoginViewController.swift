//
//  LoginViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 22/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

public var LoggedInEmail : String? = nil
public let SERVER_URL: String = "http://andrewsong17.pythonanywhere.com"

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAttempt(_ sender: UIButton) {
        let email = emailField.text
        let pw = passwordField.text
        var loginSuccess : Bool = false
        let parameters: Parameters = [
            "email":email!,
            "password":pw!
        ]
        Alamofire.request("\(SERVER_URL)/accounts/login/", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
                if let loginJSON = response.result.value{
                    if let loginObj : Dictionary = loginJSON as? Dictionary<String, Any>{
                        LoggedInEmail = loginObj["email"] as? String
                        loginSuccess = true
                        self.goToSegue(loginSuccess)
                        
                    }
                    else{
                        self.createAlert(title: "Login failed", message: "Please try again")
                    }
                }
                else{
                    self.createAlert(title: "Login failed", message: "Please try again")
                }
        }
    }
    
    func goToSegue(_ loginSuccess : Bool){
        if(loginSuccess == true){
            let parameters: Parameters = ["email":LoggedInEmail!]
            var accountType : String = ""
            Alamofire.request("\(SERVER_URL)/accounts/account-type/", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
                if let loginJSON = response.result.value{
                    print("Login JSON:")
                    print(loginJSON)
                    accountType = loginJSON as! String
                    print(accountType)
                    if(accountType == "Giver"){
                        self.performSegue(withIdentifier: "giverPath", sender: self)
                    }
                    else{
                        self.performSegue(withIdentifier: "adopterPath", sender: self)
                    }
                }
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
