//
//  GiverWelcomeViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 2/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class GiverWelcomeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    private var listing = false
    private var ID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func changeName(){
        print("The email input is"+LoggedInEmail!)
        let parameters: Parameters = ["email": LoggedInEmail!]
        let url = SERVER_URL + "/accounts/giver-data/"
        print("\nThe url used is: \(url)")
        Alamofire.request(url, method: .put, parameters: parameters).responseJSON{ response in
            print("\nAlamofire response:\n\(response)")
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String, Any> {
                    let adopterObj: Dictionary = userObj["Giver Data"] as! Dictionary<String, Any>
                    self.nameLabel.text = adopterObj["first_name"]! as? String
                    self.ID = adopterObj["id"]! as! Int
                    print(adopterObj["first_name"]!)
                }
            }
        }
        
    }
    @IBAction func listingPet(_ sender: Any) {
        listing = true
        performSegue(withIdentifier: "listing", sender: self)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        LoggedInEmail = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(listing){
            let receiving = segue.destination as! AddPetViewController
            print(ID)
            receiving.setID(ID)
        }
    }
}
