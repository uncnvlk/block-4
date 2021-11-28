//
//  ProfileController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 22.10.2021.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    let account = Account.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id.text = account.login
        name.text = account.name
    }
}

