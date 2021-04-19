//
//  PostTableViewCell.swift
//  SocialKit
//
//  Created by rayner on 19/04/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postDescription: UILabel!
    
    var post: PostUser? {
        didSet {
            self.postDescription.text = post?.title
        }
    }

}
