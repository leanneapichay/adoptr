//
//  MatchViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 30/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class AdopterMatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

// change this to an array of pets from alamofire
private let elements = ["pet1","pet2","pet3"]

    
@IBOutlet weak var tableView: UITableView!

override func viewDidLoad() {
    super.viewDidLoad()
    
    
}
//ALAMOFIRE METHOD
private func getElements(){
    Alamofire.request("\(SERVER_URL)/feed/completed-matches", method: .put, parameters: ["email":LoggedInEmail!], encoding: JSONEncoding.default).responseJSON{ response in
        print(response)
        
    }
}


    
//TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listedCell") as! AdopterMatchTableViewCell
        
        cell.cellView.layer.cornerRadius = (cell.cellView.frame.height / 2)
        
        return cell
    }


    
    
    //PREPARE FOR
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let upcoming : MatchPreviewViewController = segue.destination as! MatchPreviewViewController
    
    let indexPath = self.tableView.indexPathsForSelectedRows
    
 }
    
@IBAction func moreinfo(_ sender: UIButton) {
    performSegue(withIdentifier: "showOwnerView", sender: self)
}
    
}





