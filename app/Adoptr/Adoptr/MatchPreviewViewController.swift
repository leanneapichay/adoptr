//
//  MatchPreviewViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 30/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class MatchPreviewViewController: UIViewController {
    
    private var userID: Int? = nil
    private var petID: Int? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var petMatchLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var currentPetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameter: Parameters = ["id": userID!]
        Alamofire.request("\(SERVER_URL)/accounts/adopter-id/", method: .put, parameters: parameter).responseJSON{ response in
            print(response)
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String, Any> {
                    let adopterObj: Dictionary = userObj["Giver Data"] as! Dictionary<String, Any>
                    self.nameLabel.text = (adopterObj["first_name"]! as? String)! + (adopterObj["last_name"]! as? String)!
                    self.availabilityLabel.text = (adopterObj["availability"]! as? String)
                    self.currentPetLabel.text = (adopterObj["num_pets"]! as? String)
                }
            }
        
        }
        Alamofire.request("\(SERVER_URL)/dogs/dog-info/", method: .put, parameters: parameter).responseJSON{ response in
            print(response)
            if let userJSON = response.result.value{
                if let petObj : Dictionary = userJSON as? Dictionary<String, Any> {
                    petMatchLabel.text = "matched for : \(petObj["name"] as? String)"
                }
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func setID(_ input: Int, _ inputPet: Int){
        userID = input
        petID = inputPet
    }
}
