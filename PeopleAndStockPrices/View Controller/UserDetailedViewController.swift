//
//  UserDetailedViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import SAConfettiView

class UserDetailedViewController: UIViewController {
    var detailedUser:Person!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userStreet: UILabel!
    @IBOutlet var userCity: UILabel!
    @IBOutlet var userState: UILabel!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundAnimation()
        setupDetailedVC()
    }
    func setupBackgroundAnimation(){
      let confetti = SAConfettiView(frame: self.view.bounds)
        
        switch detailedUser.gender{
        case "female":
            confetti.type = .Star
        default:
            confetti.type = .Diamond
        }
        view.addSubview(confetti)
        confetti.startConfetti()
    }
    
    func setupDetailedVC(){
        
        userImage.image = UIImage(named: "profileImage")
        userImage.layer.borderWidth = 4
        userImage.layer.borderColor = UIColor.white.cgColor
        userName.text = detailedUser.name.convertFirstLetterOfNameToUpperCase()
        userEmail.text = detailedUser.email
        userStreet.text = detailedUser.location.street
        userCity.text = detailedUser.location.city
        userState.text = detailedUser.location.state
        //self.activityIndicatorView.stopAnimating()
    }
}
