//
//  StockPriceDetailedViewController.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class StockPriceDetailedViewController: UIViewController {
    var stock:Days!
    @IBOutlet var stockImage: UIImageView!
    @IBOutlet var stockDate: UILabel!
    @IBOutlet var openPrice: UILabel!
    @IBOutlet var closePrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetailedVC()
    }
    
    func setupDetailedVC(){
        stockDate.text = stock.date
        openPrice.text = "OPEN: \(stock.open)"
        closePrice.text = "PREV ClOSE: \(stock.close)"
        
        if stock.open > stock.close{
            stockImage.image = UIImage(named: "bullish")
            view.backgroundColor = .green
        }else{
            stockImage.image = UIImage(named: "bears")
            view.backgroundColor = .red
        }
    }


}
