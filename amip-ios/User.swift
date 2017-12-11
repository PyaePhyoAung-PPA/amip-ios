//
//  User.swift
//  amip-ios
//
//  Created by Administrator on 12/4/17.
//  Copyright © 2017 Thuriya ACE Technology. All rights reserved.
//

import UIKit

struct User {
    
     var usercode : String
     var password : String
     var status : String
    
    init (usercode:String, password : String , status: String) {
        self.usercode = usercode
        self.password = password
        self.status = status
    }
        
    
}
