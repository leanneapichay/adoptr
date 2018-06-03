//
//  MatchViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 30/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class MatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

// change this to an array of pets from alamofire
private let elements = ["pet1","pet2","pet3"]

@IBOutlet weak var tableView: UITableView!

override func viewDidLoad() {
    
    tableView.delegate = self
    tableView.dataSource = self

    super.viewDidLoad()
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elements.count
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listedCell") as! ListedPetViewCell
    
    cell.cellView.layer.cornerRadius = (cell.cellView.frame.height / 2)
    
    //cell.ownerName.text =           initialize with alamofire
    //cell.ownerImage.image =
    
    cell.petImage.layer.cornerRadius = (cell.petImage.frame.height/2)
    
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showView", sender: self)
}

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var upcoming : MatchPreviewViewController = segue.destination as! MatchPreviewViewController
    
    let indexPath = self.tableView.indexPathsForSelectedRows
    
    upcoming.setID(1)
 }
@IBAction func moreinfo(_ sender: UIButton) {
    performSegue(withIdentifier: "showOwnerView", sender: self)
}
    
}

