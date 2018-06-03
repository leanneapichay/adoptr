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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func changeName(){
        print(LoggedInEmail!)
        let parameters: Parameters = ["email": LoggedInEmail!]
        let url = SERVER_URL + "/accounts/adopter-data/"
        print("\n\(url)")
        Alamofire.request(url, method: .put, parameters: parameters).responseJSON{ response in
            print("\nAlamofire response:\n\(response)")
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String, Any> {
                    let adopterObj: Dictionary = userObj["Adopter Data"] as! Dictionary<String, Any>
                    self.nameLabel.text = adopterObj["first_name"]! as? String
                    print(adopterObj["first_name"]!)
                }
            }
        }
        
    }

}
