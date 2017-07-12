//
//  AuthService.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/11/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if errorCode == AuthErrorCode.userNotFound {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            // Show Error to User
                        } else {
                            if user?.uid != nil {
                                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                    if error != nil {
                                        // Show Error to user
                                    } else {
                                        // we have successfully logged in
                                    }
                                })
                            }
                        }
                    })
                } else {
                    // Handle all other errors
                }
                
            } else {
                //Handle Success
            }
            
        }
    }
}
