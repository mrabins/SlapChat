//
//  UsersVC.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/16/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class UsersVC: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [User]()
    var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
         return _videoURL
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.allowsMultipleSelection = true
        
        firebaseUserRequest()
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func firebaseUserRequest() {
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            print("IAM THE \(profile)")
                            if let firstName = profile["firstName"] as? String {
                                if let lastName = profile["lastName"] as? String {
                                    let uid = key
                                    let user = User(firstName: firstName, lastName: lastName, uid: uid)
                                    self.users.append(user)
                                }
                                
                            }
                        }
                    }
                }
            }
            self.usersTableView.reloadData()
        }
    }
    
    @IBAction func sendSlapButtonPressed(sender: AnyObject) {
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            _ = ref.putFile(from: url, metadata: nil, completion: { (meta: StorageMetadata?, err: NSError?) in
                if err != nil {
                    print("Error Uploading Video: \(String(describing: err?.localizedDescription))")
                } else {
                    let downloadURL = meta!.downloadURL()
                    // save downloadURL Somewhere
                    self.dismiss(animated: true, completion: nil)
                }
            } as? (StorageMetadata?, Error?) -> Void)

        } else if let slap = _snapData {
            let ref = DataService.instance.imageStorageRef.child("\(NSUUID().uuidString).jpg")
            _ = ref.putData(slap, metadata: nil, completion: { (meta: StorageMetadata?, err: NSError?) in
                
                if err != nil {
                    print("Error Uploading snapshot: \(String(describing: err?.localizedDescription))")
                } else {
                    let downloadURL = meta!.downloadURL()
                    self.dismiss(animated: true, completion: nil)
                }
                
            } as? (StorageMetadata?, Error?) -> Void)
            
        }
        // ** TODO - Add Loading Spinner
    }
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = usersTableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = usersTableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
        
        if selectedUsers.count <= 0 {
            navigationItem.backBarButtonItem?.isEnabled = false
        }
    }
}

extension UsersVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
        let user = users[indexPath.row]
        cell?.updateUI(user: user)
        return cell!
    }
    
    
    
}
