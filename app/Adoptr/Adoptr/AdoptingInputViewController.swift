//
//  AdoptingInputViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 1/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class AdoptingInputViewController: UIViewController {
   
    private var data: [String:String]? = nil
    private var away : Int? = nil
    
    @IBOutlet weak var AwaySlider: UISlider!
    @IBOutlet weak var petAmountLabel: UILabel!
    
    @IBOutlet weak var smallSwitch: UISwitch!
    @IBOutlet weak var medSwitch: UISwitch!
    @IBOutlet weak var largeSwitch: UISwitch!
    
    @IBOutlet weak var puppySwitch: UISwitch!
    @IBOutlet weak var adultSwitch: UISwitch!
    @IBOutlet weak var matureSwitch: UISwitch!
    
    @IBOutlet weak var hypoSwitch: UISwitch!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var pretrainedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public func setData(inputData: [String:String]) {
        data = inputData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func petStepper(_ sender: UIStepper) {
        petAmountLabel.text = String(sender.value)
    }
    
    @IBAction func storeSliderVal(_ sender: UISlider) {
        away = Int(sender.value)
    }
    
    @IBAction func presedNext(_ sender: UIButton) {
        var size: String
        var age: String
        var traits: String
        
        //determine size booleans
        if(smallSwitch.isOn){
            if(medSwitch.isOn){
                if(largeSwitch.isOn){
                    size = "111"
                }
                else{
                    size = "110"
                }
            }
            else{
                if(largeSwitch.isOn){
                    size = "101"
                }
                else{
                    size = "100"
                }
            }
            
        }
        else{
            if(medSwitch.isOn){
                if(largeSwitch.isOn){
                    size = "011"
                }
                else{
                    size = "010"
                }
            }
            else{
                if(largeSwitch.isOn){
                    size = "001"
                }
                else{
                    size = "000"
                }
            }
        }
        
        //determine age booleans
        if(puppySwitch.isOn){
            if(adultSwitch.isOn){
                if(matureSwitch.isOn){
                    age = "111"
                }
                else{
                    age = "110"
                }
            }
            else{
                if(matureSwitch.isOn){
                    age = "101"
                }
                else{
                    age = "100"
                }
            }
            
        }
        else{
            if(adultSwitch.isOn){
                if(matureSwitch.isOn){
                    age = "011"
                }
                else{
                    age = "010"
                }
            }
            else{
                if(matureSwitch.isOn){
                    age = "001"
                }
                else{
                    age = "000"
                }
            }
        }
        
        //determine trait booleans
        if(hypoSwitch.isOn){
            if(activeSwitch.isOn){
                if(pretrainedSwitch.isOn){
                    traits = "111"
                }
                else{
                    traits = "110"
                }
            }
            else{
                if(pretrainedSwitch.isOn){
                    traits = "101"
                }
                else{
                    traits = "100"
                }
            }
            
        }
        else{
            if(activeSwitch.isOn){
                if(pretrainedSwitch.isOn){
                    traits = "011"
                }
                else{
                    traits = "010"
                }
            }
            else{
                if(pretrainedSwitch.isOn){
                    traits = "001"
                }
                else{
                    traits = "000"
                }
            }
        }
        
        let parameters: Parameters = [
            //take data out from the input dictionary
            "first_name":data!["firstName"]!,
            "last_name": data!["lastName"]!,
            "email":data!["email"]!,
            "zip_code": data!["zip"]!,
            "birthdate": data!["birthdate"]!,
            "password":data!["password"]!,
            
            //adoption-centric info
            "availability" : away!,
            "num_pets" : petAmountLabel.text!,
            "size" : size,
            "age" : age,
            "traits" : traits
        ]
        Alamofire.request("http://661aef61.ngrok.io/dogs/create-dog/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
}
