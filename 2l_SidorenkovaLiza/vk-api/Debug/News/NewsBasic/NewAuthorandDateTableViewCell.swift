//
//  NewAuthorandDateTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 27.11.2021.
//

import UIKit

class NewAuthorandDateTableViewCell: UITableViewCell {

    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postDate: UILabel!

    func configure(authorPhotoFromVK: String, authorNameFromVK: String, postDateFromVK: String){
        self.authorPhoto.image = UIImage(named:"authorPhotoFromVK")
        self.authorName.text = authorNameFromVK
        self.postDate.text = postDateFromVK
        
    }
}
