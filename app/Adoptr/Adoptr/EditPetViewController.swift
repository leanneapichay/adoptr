//
//  EditPetViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 1/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class EditPetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var breed: UITextField!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var active: UILabel!
    @IBOutlet weak var trained: UILabel!
    
    @IBOutlet weak var sizePicker: UIPickerView!

    @IBOutlet weak var bio: UITextView!
    
    private let sizes = ["small", "medium", "large"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameter: Parameters = ["dog_id" : 5]
        Alamofire.request("http://661aef61.ngrok.io/dogs/create-dog/", method: .post, parameters: parameter).responseJSON{ response in
            print(response)
            if let petJSON = response.result.value{
                let petObj : Dictionary = petJSON as! Dictionary<String, Any>
                self.name.text = petObj["name"] as? String
                self.breed.text = petObj["breed"] as? String
                self.age.text = petObj["age"] as? String
                self.active.text = petObj["active"] as? String
                self.trained.text = petObj["trained"] as? String
                self.bio.text = petObj["description"] as? String
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = sizes[row]
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 11.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        
        return myTitle
        
    }
    
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
        
    @IBAction func ageStepper(_ sender: UIStepper) {
        age.text = String(Int(sender.value))
    }
    
    @IBAction func activeStepper(_ sender: UIStepper) {
        active.text = String(Int(sender.value))
    }
    
    @IBAction func trainedStepper(_ sender: UIStepper) {
        trained.text = String(Int(sender.value))
    }

}
