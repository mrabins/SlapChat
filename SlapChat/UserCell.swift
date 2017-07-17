//
//  UserCell.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/16/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLabal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firstNameLabal.text = user.firstName
        
    }
    
    func setCheckmark(selected: Bool) {
        let imageString = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageString))
    }
}

