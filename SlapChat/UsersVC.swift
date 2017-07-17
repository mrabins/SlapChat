//
//  UsersVC.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/16/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersVC: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [User]()
    var selectedUsers = Dictionary<String, User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.allowsMultipleSelection = true
        
        firebaseUserRequest()
        
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
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = usersTableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = usersTableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
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
