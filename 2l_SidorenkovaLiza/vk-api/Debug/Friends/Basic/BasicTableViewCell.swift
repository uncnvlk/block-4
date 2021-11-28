//
//  BasicTableViewCell.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 16.09.2021.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var friendImage: UIImageView!
    
    func configure(with item: FriendModels) {
        self.friendLabel.text = item.fullName
        self.addPhoto(with: item)
    }
    
    func addPhoto(with item: FriendModels) {
        let url = URL(string: item.photo100 )

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.friendImage.image = UIImage(data: data!)
            }
        }
    }
    
}
