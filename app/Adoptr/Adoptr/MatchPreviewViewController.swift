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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var petMatchLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var currentPetLabel: UILabel!
    @IBOutlet weak var bioField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parameter: Parameters = ["id": userID!]
        Alamofire.request("http://661aef61.ngrok.io/dogs/create-dog/", method: .post, parameters: parameter).responseJSON{ response in
            print(response)
            if let acctJSON = response.result.value{
                let acctObj : Dictionary = acctJSON as! Dictionary<String, Any>
                self
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func setID(_ input: Int){
        userID = input
    }
}
