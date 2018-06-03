//
//  GivingSignUpViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 25/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class GivingSignUpViewController: UIViewController {
    private var data: [String:String]? = nil
    @IBOutlet weak var shelterSwitch: UISwitch!
    @IBOutlet weak var shelterNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setData(inputData: [String:String]) {
        data = inputData
    }

    @IBAction func createAcc(_ sender: UIButton) {
        var shelter: Bool
        var shelterName: String?
        
        if(shelterSwitch.isOn){
            shelter = true
            shelterName = shelterNameField.text
        }
        else{
            shelter = false
            shelterName = "N/A"
        }
        let parameters: Parameters = [
            //take data out from the input dictionary
            "first_name":data!["firstName"]!,
            "last_name": data!["lastName"]!,
            "email":data!["email"]!,
            "zip_code": data!["zip"]!,
            "password":data!["password"]!,
            
            //adoption-centric info
            "independent" : shelter,
            "shelterName" : shelterName!
        ]
        Alamofire.request("\(SERVER_URL)/accounts/create-giver/ email=giver2@test.com", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
}
