//
//  AuthService.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/11/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errorMessage: String?, _ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: @escaping Completion) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == AuthErrorCode.userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handlerForFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handlerForFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        // Handle all other errors
                        self.handlerForFirebaseError(error: error! as NSError, onComplete: onComplete)
                    }
                    
                } else {
                    //Handle Success
                    onComplete(nil, user)
                }
                
            }
        }
    }
    
    func handlerForFirebaseError(error: NSError, onComplete: Completion) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .invalidEmail:
                onComplete("Invalid Email address", nil)
                break
            case .wrongPassword:
                onComplete("Invalid Password", nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete("Could not create an account. The email used already belongs to a user", nil)
                break
            default:
                onComplete("There was a problem authenricating. Please Try Again.", nil)
            }
            
        }
    }
}
