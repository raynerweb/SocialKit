//
//  UserTableViewCell.swift
//  SocialKit
//
//  Created by rayner on 18/04/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: User? {
        didSet {
            self.nameLabel.text = user?.name
            self.emailLabel.text = user?.email
        }
    }
    
    
//    func set(name: String, email: String) {
//        nameLabel.text = name
//        emailLabel.text = email
//    }
    
    
}
