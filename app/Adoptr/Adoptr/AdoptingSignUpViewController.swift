//
//  AdoptingSignUpViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 23/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class AdoptingSignUpViewController: UIViewController {

    @IBOutlet weak var BdayPicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BdayPicker.setValue(UIColor.white, forKey: "textColor")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
