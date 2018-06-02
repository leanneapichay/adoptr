//
//  AcctSplitViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 2/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class AcctSplitViewController: UIViewController {
    
    private var data: [String:String]? = nil
    private var adopting : Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func setData(inputData: [String:String]) {
        data = inputData
    }
    
    @IBAction func pressAdopting(_ sender: UIButton) {
        adopting = true
        performSegue(withIdentifier: "adoptingPath", sender: self)
    }
    
    @IBAction func pressGiving(_ sender: UIButton) {
        adopting = false
        performSegue(withIdentifier: "givingPath", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(adopting)!{
            let receiver = segue.destination as! AdoptingInputViewController
            receiver.setData(inputData: data!)
            
        }
        else{
            let receiver = segue.destination as! GivingSignUpViewController
            receiver.setData(inputData: data!)
        }
        
    }

}
