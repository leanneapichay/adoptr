//
//  FeedViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 29/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var Breed: UILabel!
    @IBOutlet weak var Active: UILabel!
    @IBOutlet weak var Trained: UILabel!
    
    private var feedInc: Int = -1
    private var swipes: Int = 0
    private var dogID: Int = 0
    private var ownerID: Int = 0
    private var pets: [Dictionary<String,Any>]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture: )))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture: )))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        nextPet()
    }
    

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped Right")
                giveResponse()
                nextPet()
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped Left")
                nextPet()
            default:
                break
            }
        }
    }
    
    private func giveResponse(){
        print("Giving response")
        let parameters : Parameters = [
            "dog":dogID,
            "owner":ownerID,
            "email":LoggedInEmail!
        
        ]
        Alamofire.request("\(SERVER_URL)/feed/make-pp-match/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }

    private func loadNewFeed(){
        feedInc += 1
        print("Feed inc: \(feedInc)")
        let parameters: Parameters = [
            "email" : LoggedInEmail!,
            "num" : self.feedInc
        ]
        Alamofire.request("\(SERVER_URL)/feed/get-feed/", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            print("Feed requst: ")
            print(response)
            if let feedJSON = response.result.value{
                if let feedObj : [Dictionary<String, Any>] = feedJSON as? [Dictionary<String,Any>] {
                    if(feedObj.count == 0){
                         self.createAlert(title: "Oops!", message: "You've seen all listed pets. Check back later to see new listings!")
                    }
                    else{
                        self.swipes = feedObj.count
                         print("Swipes inc: \(self.swipes)")
                        self.pets = feedObj
                        self.nextPet()
                    }
                    
                }
            }
        }
    }
    
    private func nextPet(){
        if (swipes > 0){
            print(pets![swipes-1])
            let currentPet = pets![swipes-1]
            self.Name.text = currentPet["name"] as? String
            self.Bio.text = currentPet["description"] as? String
            if(currentPet["active"] as? Int == 0){
                self.Active.text = "No"
            }
            else{
                self.Active.text = "Yes"
            }
            if(currentPet["trained"] as? Int == 0){
                self.Trained.text = "No"
            }
            else{
                self.Trained.text = "Yes"
            }
            self.Age.text = String(currentPet["age"] as! Int)
            self.Breed.text = currentPet["breed"] as? String
            self.dogID = (currentPet["id"] as? Int)!
            self.ownerID = (currentPet["owner"] as? Int)!
            self.swipes -= 1
        }
        else{
            loadNewFeed()
        }
    }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //creating a button
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: {
            _ in self.performSegue(withIdentifier: "feedReturn", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

