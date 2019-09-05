//
//  ViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var footer: UIView!
    @IBOutlet var footerView: UILabel!
    
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
            return allUser.filter({$0.name.convertFirstLetterOfNameToUpperCase().lowercased().replacingOccurrences(of: " ", with: "").contains(searchString.lowercased().replacingOccurrences(of: " ", with: ""))})
        }
    }
    
    var UserSearchString:String? = nil {
        didSet {
            setResultCount()
            self.userTableView.reloadData()
        }
    }
    
    private func setResultCount(){
        switch userSearchResults.count{
        case allUser.count:
            navigationItem.title = "Contacts"
        case 1:
            navigationItem.title = "You have 1 result"
        case 0:
            navigationItem.title = "You have no results"
        default:
            navigationItem.title = "You have \(userSearchResults.count) results"
        }
    }
    
    
    @IBOutlet var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUserData()
        setupNavBar()
        
    }
    
    private func setup(){
        userTableView.delegate = self
        userTableView.dataSource = self
        userSearchBar.delegate = self
    }
    
    private func setupNavBar(){
        self.navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.backgroundColor = .blue
    }
    
    fileprivate func fetchUserData(){
        UserAPIClient.shared.fetchData { (result) in
            switch result {
            case .failure( _):
                print("cant retrieve user \(UserError.cantProcessData)")
            case .success(let user):
                self.allUser = user.sorted(by: {$0.name.first < $1.name.first})
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
        
        cell.textLabel?.text = info.name.convertFirstLetterOfNameToUpperCase()
        cell.detailTextLabel?.text = info.location.convertFistLetterOfAddressToUpperCase()
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
