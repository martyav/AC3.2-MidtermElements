//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/8/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class Element {
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let melting: Double
    let boiling: Double
    
    init(name: String, symbol:String, number:Int, weight: Double, melting: Double, boiling: Double) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.melting = melting
        self.boiling = boiling
    }
    
    convenience init?(from jsonDict: [String:AnyObject]) {
        var nameFromDict = ""
        var symbolFromDict = ""
        var numberFromDict = 0
        var weightFromDict = 0.0
        var meltingFromDict = 0.0
        var boilingFromDict = 0.0
        
        self.init(name: nameFromDict, symbol: symbolFromDict, number: numberFromDict, weight: weightFromDict, melting: meltingFromDict, boiling: boilingFromDict)
    }
}
