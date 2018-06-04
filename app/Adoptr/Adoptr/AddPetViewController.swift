//
//  AddPetViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 1/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class AddPetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private var ownerID = 0
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var trainedLabel: UILabel!
    @IBOutlet weak var hypoSwitch: UISwitch!
    
    private let sizes = ["Small", "Medium", "Large"]
    private var sizeVal: String = "Small"
    @IBOutlet weak var sizePicker: UIPickerView!
    
    @IBOutlet weak var bioField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //SIZE PICKER METHODS
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizes[row]
    }
    
    
    //STEPPER METHODS
    @IBAction func ageStepper(_ sender: UIStepper) {
        ageLabel.text = String(Int(sender.value))
    }
    
    @IBAction func activeStepper(_ sender: UIStepper) {
        activeLabel.text = String(Int(sender.value))
    }
    
    @IBAction func trainedStepper(_ sender: UIStepper) {
        trainedLabel.text = String(Int(sender.value))
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        let age = Int(ageLabel.text!)!
        var ageRange: Int = 0
        if(age<2){
            ageRange = 0
        }
        else if(age<10){
            ageRange = 1
        }
        else{
            ageRange = 2
        }
        let active = Int(activeLabel.text!)!
        var activeOn: Bool = false
        if(active>5){
            activeOn = true
        }
        let trained = Int(trainedLabel.text!)!
        var trainedOn = false
        if(trained > 5){
            trainedOn = true
        }
        let size: Int = sizePicker.selectedRow(inComponent: 0)
        print(ownerID)
        
        let parameters: Parameters = [
            "name": nameField.text!,
            "age": age,
            "age_range":ageRange,
            "breed": breedField.text!,
            "active": activeOn,
            "trained": trainedOn,
            "hypoallergenic": hypoSwitch.isOn,
            "size": size,
            "description" : bioField.text!,
            "owner": ownerID
        ]

        Alamofire.request("\(SERVER_URL)/dogs/create-dog/", method: .post, parameters: parameters, encoding: JSONEncoding.default).response{ response in
            print(response)
        }
        self.createAlert(title: "Success", message: "Your pet has been listed")
        
        performSegue(withIdentifier: "returnToMenu", sender: self)
    }
    
    public func setID(_ input: Int){
        ownerID = input
    }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //creating a button
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: {
            _ in self.performSegue(withIdentifier: "returnToMenu", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
