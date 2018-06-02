//
//  Accounts.swift
//  Adoptr
//
//  Created by Leanne Pichay on 21/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import Foundation

public class Acct {
    var name: (first: String, last: String)
    var email: String
    var password: String
    var DOB: String
    
    init(_ data: [String: String]) {
        name = (data["firstName"]!, data["lastName"]!)
        email = data["email"]!
        password = data["password"]!
        DOB = data["DOB"]!
    }
}


public class Adopting: Acct {
    var awayFromHome : Int
    var currentPets : Int
    var sizes : (small: Bool, med: Bool, large: Bool)
    var age : (puppy: Bool, adult: Bool, mature: Bool)
    var traits : (hypoallergenic: Bool, active: Bool, pretrained: Bool)
    
    init(input : Acct, _ data: [String: String]){
        let (first,last) = input.name
        let data : [String : String] = ["firstName":first, "lastName":last, "email":input.email, "password":input.password, "DOB":input.DOB]
        awayFromHome = Int(data["awayFromHome"]!)!
        currentPets = Int(data["currentPets"]!)!
        sizes = (Bool(data["small"]!)!, Bool(data["med"]!)!, Bool(data["large"]!)!)
        age = (Bool(data["puppy"]!)!, Bool(data["adult"]!)!, Bool(data["mature"]!)!)
        traits = (Bool(data["hypoalergenic"]!)!, Bool(data["active"]!)!, Bool(data["pretrained"]!)!)
        super.init(data)
    }
}

public class Giving: Acct {
    var shelterstatus: Bool
    var shelterName: String?
    init(input : Acct, type: Bool, shelter : String?){
        let (first,last) = input.name
        let data : [String : String] = ["firstName":first, "lastName":last, "email":input.email, "password":input.password, "DOB":input.DOB]
        if(type){
            shelterName = shelter
            shelterstatus = true
        }
        else{
            shelterstatus = false
        }
        super.init(data)
    }
}

