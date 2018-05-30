//
//  FeedViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 29/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var Breed: UILabel!
    @IBOutlet weak var Active: UILabel!
    @IBOutlet weak var Trained: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture(gesture:)"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture(gesture:)"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        Name.text = "Hello"
        
    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        var response : Bool
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.right:
                response = true
            case UISwipeGestureRecognizerDirection.left:
                response = false
            default:
                break
            }
        }
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

