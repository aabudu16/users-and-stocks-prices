//
//  UserDetailedViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class UserDetailedViewController: UIViewController {
    var detailedUser:Person!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetailedVC()
    }
    
    func setupDetailedVC(){
        userImage.image = UIImage(named: "profileImage")
        userName.text = detailedUser.name.convertFirstLetterToUpperCase()
        userEmail.text = detailedUser.email
        userLocation.text = detailedUser.location.state
    }
}
