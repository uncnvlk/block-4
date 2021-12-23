//
//  NewsTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 23.12.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell  {

    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var postText: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likes: UILabel!
}
