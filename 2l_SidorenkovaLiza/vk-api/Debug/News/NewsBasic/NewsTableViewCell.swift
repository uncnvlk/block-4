//
//  NewsTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 25.09.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    
    func configure(with item: NewModels) {
            self.newsLabel.text = item.text
    }
    
}
