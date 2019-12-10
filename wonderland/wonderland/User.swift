//
//  User.swift
//  wonderland
//
//  Created by Forwhfang on 2019/12/3.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "usernameKey")
        aCoder.encode(password, forKey: "passwordKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: "usernameKey") as! String
        password = aDecoder.decodeObject(forKey: "passwordKey") as! String
    }
}
