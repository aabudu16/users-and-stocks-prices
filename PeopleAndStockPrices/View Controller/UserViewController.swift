//
//  ViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var allUser:[Person]! {
        didSet{
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
    }
    
    @IBOutlet var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUserData()
    }
    
    func setup(){
        userTableView.delegate = self
        userTableView.dataSource = self
        self.navigationItem.title = "Cantacts"
    }
    
   private func fetchUserData(){
        UserAPIClient.shared.fetchData { (result) in
            switch result {
            case .failure(let error):
                print("cant retrieve user \(error)")
            case .success(let user):
                self.allUser = user.results
            }
        }
    }
}

extension UserViewController:UITableViewDelegate{}
extension UserViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = allUser else {return 0}
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let info = allUser[indexPath.row]
        
        cell.textLabel?.text = info.name.convertFirstLetterToUpperCase()
        cell.detailTextLabel?.text = info.location.state
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedUserVC = storyboard?.instantiateViewController(withIdentifier: "userDetailedVC") as! UserDetailedViewController
        
        let info = allUser[indexPath.row]
        
        detailedUserVC.detailedUser = info
        
        self.navigationController?.pushViewController(detailedUserVC, animated: true)
    }

}
