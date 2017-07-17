//
//  DataService.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/16/17.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child(FIR_USER_REF)
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://slapchat-3a450.appspot.com")
    }
    
    var imageStorageRef: StorageReference {
        return mainStorageRef.child("image")
    }
    
    var videoStorageRef: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        mainRef.child(FIR_USER_REF).child(uid).child(FIR_PROFILE_REF).setValue(profile)
    }
}
