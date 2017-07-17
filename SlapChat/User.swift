//
//  User.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/16/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation

struct User {
    private var _firstName: String
    private var _lastName: String
    private var _uid: String
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    var uid: String {
        return _uid
    }
    
    init(firstName: String, lastName: String, uid: String) {
        _firstName = firstName
        _lastName = lastName
        _uid = uid
    }
    
}
