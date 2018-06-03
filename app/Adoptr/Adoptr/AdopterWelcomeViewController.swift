//
//  AdopterWelcomeViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 2/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class AdopterWelcomeViewController: UIViewController {

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
        var name : String = "name"
        print(LoggedInEmail!)
        let parameters: Parameters = ["email":LoggedInEmail!]
        let url = "\(SERVER_URL)/accounts/adopter-data/"
        print("\n\(url)")
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{ response in
            print("\nAlamofire response:\n\(response)")
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String, Any> {
                    name = userObj["first_name"] as! String
                }
            }
        }
        self.nameLabel.text = name
    }
}
