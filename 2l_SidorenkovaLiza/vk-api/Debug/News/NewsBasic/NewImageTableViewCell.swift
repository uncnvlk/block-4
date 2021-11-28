//
//  NewImageTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 27.11.2021.
//

import UIKit

class NewImageTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    func configure(postImageFromVK: String){
        self.postImage.image = UIImage(named: "postImageFromVK")
    }
    
}
