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

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var trainedLabel: UILabel!
    
    private let sizes = ["Small", "Medium", "Large"]
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
        let parameters: Parameters = [
            "name": nameField.text!,
            "breed": breedField.text!,
            "age": Int(ageLabel.text!)!,
            "active": Int(activeLabel.text!)!,
            "trained": Int(trainedLabel.text!)!,
            "description" : bioField.text!
        ]

        Alamofire.request("http://661aef61.ngrok.io/dogs/create-dog/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        performSegue(withIdentifier: "nextView", sender: self)
    }
    
}
