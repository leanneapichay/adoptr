//
//  PreferenceChangeViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 1/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class PreferenceChangeViewController: UIViewController {

    @IBOutlet weak var activeAccSwitch: UISwitch!
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
        let url = "\(SERVER_URL)/accounts/adopter-data/ "
        Alamofire.request(url, method: .get, parameters: ["email":LoggedInEmail!]).responseJSON{ response in
            print(response)
            if let JSON = response.result.value{
                if let accObj : Dictionary = JSON as? Dictionary<String, Any>{
                    let size:String = (accObj["size"]! as? String)!
                    let age : String = (accObj["age"]! as? String)!
                    let traits : String = (accObj["traits"]! as? String)!
                    
                    //check left buttons
                    var index = size.startIndex
                    if(size[index] == "0"){
                        self.smallSwitch.setOn(false, animated: true)
                    }
                    if(age[index] == "0"){
                        self.puppySwitch.setOn(false, animated: true)
                    }
                    if(traits[index] == "0"){
                        self.hypoSwitch.setOn(false, animated: true)
                    }
                    
                    //check mid buttons
                    index = size.index(after: size.startIndex)
                    if(size[index] == "0"){
                        self.medSwitch.setOn(false, animated: true)
                    }
                    if(age[index] == "0"){
                        self.adultSwitch.setOn(false, animated: true)
                    }
                    if(traits[index] == "0"){
                        self.activeSwitch.setOn(false, animated: true)
                    }
                    
                    //check right buttons
                    index = size.endIndex
                    if(size[index]=="0") {
                        self.largeSwitch.setOn(false, animated: true)
                    }
                    if(age[index] == "0") {
                        self.matureSwitch.setOn(false, animated: true)
                    }
                    if(traits[index] == "0") {
                        self.pretrainedSwitch.setOn(false, animated: true)
                    }
                    
                    self.petAmountLabel.text = (accObj["num_pets"] as? String)!
                    self.AwaySlider.setValue((accObj["availability"] as? Float)!, animated: true)
                }
                
            }
        }
    }
        
            
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func petStepper(_ sender: UIStepper) {
        let prev: Int = Int(petAmountLabel.text!)!
        petAmountLabel.text = String(Int(sender.value) + prev)
    }
}
