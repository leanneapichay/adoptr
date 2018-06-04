//
//  GiverMatchViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 3/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class GiverMatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // change this to an array of pets from alamofire
    private var elements: [Dictionary<String,Any>] = []
    private var adopterID = 0
    private var petID = 0
    private var matchID = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getElements()
    }
    
    //ALAMOFIRE METHOD
    private func getElements(){
        Alamofire.request("\(SERVER_URL)/feed/matches/", method: .put, parameters: ["email":LoggedInEmail], encoding: JSONEncoding.default).responseJSON{ response in
            print(response)
            if let userJSON = response.result.value{
                if let userObj : [Dictionary<String,Any>] = userJSON as? [ Dictionary<String, Any>] {
                    self.elements = userObj
                }
       
            }
        }
    }

    
    
    
    //TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! GiverMatchTableViewCell
        let index = indexPath.row
        cell.cellView.layer.cornerRadius = (cell.cellView.frame.height / 2)
        var adopterIDloc = (elements[index]["adopter"] as? Int)!
        matchID = (elements[index]["match"] as? Int)!
        cell.adoptName.text = getAdopter(adopterIDloc)
        cell.petName.text = getPet((elements[index]["pet"] as? Int)!)

        return cell
    }
    
    private func getAdopter(_ input: Int) -> String{
        var name: String = ""
        Alamofire.request("\(SERVER_URL)/accounts/adopter-id/", method: .put, parameters: ["id":input], encoding: JSONEncoding.default).responseJSON{ response in
            print(response)
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String,Any> {
                    name = (userObj["first_name"] as? String)!
                    
                }
            }
        }
        return name
    }
    
    private func getPet(_ input: Int) -> String{
        var name: String = ""
        Alamofire.request("\(SERVER_URL)/dogs/dog-info/", method: .put, parameters: ["id":input], encoding: JSONEncoding.default).responseJSON{ response in
            print(response)
            if let userJSON = response.result.value{
                if let userObj : Dictionary = userJSON as? Dictionary<String,Any> {
                    name = (userObj["name"] as? String)!
                }
            }
        }
        return name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.adopterID = (elements[indexPath.row]["adopter"] as? Int)!
        self.petID = (elements[indexPath.row]["pet"] as? Int)!
        self.matchID = (elements[indexPath.row]["pet"] as? Int)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiver = segue.destination as! MatchPreviewViewController
        receiver.setID(adopterID, petID, matchID)
        
    }
    
    

}
