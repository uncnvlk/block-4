//
//  NewTextTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 27.11.2021.
//

import UIKit

class NewTextTableViewCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    
    func configure(postTextFromVK: String){
        self.postText.text = postTextFromVK
    }
    
}
