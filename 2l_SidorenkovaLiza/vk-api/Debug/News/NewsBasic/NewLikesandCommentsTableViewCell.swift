//
//  NewLikesandCommentsTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 27.11.2021.
//

import UIKit

class NewLikesandCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    func configure(likesFromVK: String, commentsFromVK: String){
        self.likes.text = likesFromVK
        self.comments.text = commentsFromVK
    }
    
}
