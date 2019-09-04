//
//  StockModel.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 9/2/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

struct Days:Codable{
    let date:String
    let open:Double
    let close:Double
    let high:Double
    let low:Double
    let volume:Double
    let uOpen:Double
    let uClose:Double
    let uHigh:Double
    let uLow:Double
    let uVolume:Double
    let change:Double
    let changePercent:Double
    let label:String
    let changeOverTime:Double
}

