//
//  StockPriceViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class StockPriceViewController: UIViewController {
    @IBOutlet var stockTableView: UITableView!
    var stockData = [Days](){
        didSet{
            DispatchQueue.main.async {
                self.stockTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
   private func setupView(){
        stockTableView.delegate = self
        stockTableView.dataSource = self
    navigationItem.title = "STOCKS"
    navigationController?.navigationBar.backgroundColor = .red
    }
    fileprivate func fetchData(){
        StockAPIClient.shared.fetchStockData { (result) in
            switch result{
            case .failure(let error):
                print("Cant process data \(error)")
            case .success(let stockInfo):
                self.stockData = stockInfo
            }
        }
    }
}
extension StockPriceViewController: UITableViewDelegate{}
extension StockPriceViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return stockData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockPriceCell") else {return UITableViewCell()}
        
        let info = stockData[indexPath.row]
        
        cell.textLabel?.text = info.date
        cell.detailTextLabel?.text = "\(info.open)"
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "StockPriceDetailedVC") as? StockPriceDetailedViewController else {return}
        
        let info = stockData[indexPath.row]
        
        detailedVC.stock = info
        
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}
