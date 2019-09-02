//
//  ViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var userSearchBar: UISearchBar!
    
    var allUser = [Person]() {
        didSet{
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
    }
    
    var userSearchResults:[Person] {
        get{
            guard let searchString = UserSearchString else {
                return allUser
            }
            guard searchString != "" else {
                return allUser
            }
            return allUser.filter({$0.name.convertFirstLetterToUpperCase().lowercased().replacingOccurrences(of: " ", with: "").contains(searchString.lowercased().replacingOccurrences(of: " ", with: ""))})
        }
    }
    
    var UserSearchString:String? = nil {
        didSet {
            self.userTableView.reloadData()
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
        userSearchBar.delegate = self
        self.navigationItem.title = "Contacts"
    }
    
   private func fetchUserData(){
        UserAPIClient.shared.fetchData { (result) in
            switch result {
            case .failure( _):
                print("cant retrieve user \(userError.cantProcessData)")
            case .success(let user):
                self.allUser = user
            }
        }
    }
}

extension UserViewController:UITableViewDelegate{}
extension UserViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return userSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let info = userSearchResults[indexPath.row]
        
        cell.textLabel?.text = info.name.convertFirstLetterToUpperCase()
        cell.detailTextLabel?.text = info.location.state
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedUserVC = storyboard?.instantiateViewController(withIdentifier: "userDetailedVC") as! UserDetailedViewController
        
        let info = userSearchResults[indexPath.row]
        
        detailedUserVC.detailedUser = info
        
        self.navigationController?.pushViewController(detailedUserVC, animated: true)
    }
}

extension UserViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UserSearchString = searchBar.text
    }
}
