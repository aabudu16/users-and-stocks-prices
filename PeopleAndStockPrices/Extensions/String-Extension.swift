//
//  String-Extension.swift
//  PeopleAndStockPrices
//
//  Created by Mr Wonderful on 8/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit


    extension String {
        func capitalizingFirstLetter() -> String {
            return prefix(1).capitalized + dropFirst()
        }
        
//        mutating func capitalizeFirstLetter() {
//            self = self.capitalizingFirstLetter()
//        }
    }

