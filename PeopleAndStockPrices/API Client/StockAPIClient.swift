//
//  StockAPIClient.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 9/2/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

enum StockError:Error{
    case noDataAvailable
    case cantProcessData
    case urlCanNotBeConverted
}

struct StockAPIClient{
static let shared = StockAPIClient()
let stockApiKey = "Tpk_99a13d1c51654f2ab13764626efa902a"

    func fetchStockData(complition: @escaping (Result<[Days], StockError>)->()){
      let StockURL = "https://sandbox.iexapis.com/stable/stock/AAPL/chart/1m?token=\(stockApiKey)"
        guard let url = URL(string: StockURL) else {complition(.failure(.urlCanNotBeConverted))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            
            if let _ = err {
                complition(.failure(.noDataAvailable))
                return
            }
           
            guard let retrievedData = data else { complition(.failure(.noDataAvailable))
                return
            }
                do {
                    let stockResponse = try JSONDecoder().decode([Days].self, from: retrievedData )
                    let data = stockResponse
                    complition(.success(data))
                }catch{
                   complition(.failure(.cantProcessData))
            }
            
            
        }.resume()
    }
}
