//
//  UserModel.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit

struct UserData : Codable {
    
    var firstName : String = K.emptyString
    var lastName : String = K.emptyString
    var emailAddress : String = K.emptyString
}

struct UserList : Codable {
    
    var data : [UserRecord]
}

struct UserRecord : Codable {
    
    var firstName : String = K.emptyString
    var lastName : String = K.emptyString
}






