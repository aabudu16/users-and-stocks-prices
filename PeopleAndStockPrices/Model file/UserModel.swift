//
//  UserModel.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit


class ResultWrapper:Codable{
    let results:[Person]
}

struct Person:Codable{
    let gender:String
    let name:[PersonsName]
    let location:[Location]
    let email:String
    let dob:[DOB]
}

struct PersonsName:Codable{
    let title:String
    let first:String
    let last:String
    
    func toUpperCase() -> String{
        let fullName = "\(title.uppercased()) \(first.uppercased()) \(last.uppercased())"
        return fullName
    }
}

struct Location:Codable{
    let street:String
    let city:String
    let state:String
}

struct DOB:Codable{
    let date:String
    let age:Int
}
