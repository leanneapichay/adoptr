//
//  PreferenceChangeViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 1/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class PreferenceChangeViewController: UIViewController {

    @IBOutlet weak var activeAccSwitch: UISwitch!
    @IBOutlet weak var AwaySlider: UISlider!
    @IBOutlet weak var petAmountLabel: UILabel!
    
    @IBOutlet weak var smallSwitch: UISwitch!
    @IBOutlet weak var medSwitch: UISwitch!
    @IBOutlet weak var largeSwitch: UISwitch!
    
    @IBOutlet weak var puppySwitch: UISwitch!
    @IBOutlet weak var adultSwitch: UISwitch!
    @IBOutlet weak var matureSwitch: UISwitch!
    
    @IBOutlet weak var hypoSwitch: UISwitch!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var pretrainedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func petStepper(_ sender: UIStepper) {
        petAmountLabel.text = String(sender.value)
    }
}
