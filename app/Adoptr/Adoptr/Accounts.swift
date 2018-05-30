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
    
}

public class Giving: Acct {
    
}
