//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/8/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case results(json: Any)
    case image(image: Any)
}


class Element {
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let melting: Int
    let boiling: Int
    let density: Double
    let discovery: String
    let electrons: String
    let group: Int
    
    init(name: String, symbol:String, number:Int, weight: Double, discovered: String, group: Int, melting: Int, boiling: Int, density: Double, electrons: String) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.discovery = discovered
        self.group = group
        self.melting = melting
        self.boiling = boiling
        self.density = density
        self.electrons = electrons
    }
    
    init?(from elementDict: [String:AnyObject]) {
        //var nameFromDict: String?
        //var symbolFromDict = "Unknown"
        //var numberFromDict = 0
        //var weightFromDict = 0.0
        //var meltingFromDict = 0
        //var boilingFromDict = 0
        
        guard let nameFromDict = elementDict["name"] as? String,
            let numberFromDict = elementDict["number"] as? Int,
            let symbolFromDict = elementDict["symbol"] as? String,
            let weightFromDict = elementDict["weight"] as? Double,
            let discoveredFromDict = elementDict["discovery_year"] as? String
            else { return nil }
        
        self.name = nameFromDict
        self.number = numberFromDict
        self.symbol = symbolFromDict
        self.weight = weightFromDict
        self.discovery = discoveredFromDict
    
        if let meltingFromDict = elementDict["melting_c"] as? Int {
            self.melting = meltingFromDict
        } else {
            self.melting = 000
        }
        
        if let boilingFromDict = elementDict["boiling_c"] as? Int {
            self.boiling = boilingFromDict
        } else {
            self.boiling = 000
        }
        
        if let densityFromDict = elementDict["density"] as? Double {
            self.density = densityFromDict
        } else {
            self.density = 0.00
        }
        
        if let electronsFromDict = elementDict["electrons"] as? String {
            self.electrons = electronsFromDict
        } else {
            self.electrons = "Unknown"
        }
        
        if let groupFromDict = elementDict["group"] as? Int {
            self.group = groupFromDict
        } else {
            self.group = 0
        }
        
    }
    
    static func createElementArr(from data: Data?) -> [Element]? {
        var newArr: [Element] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let response: [[String : AnyObject]] = jsonData as? [[String : AnyObject]] else {
                    throw ParseError.results(json: jsonData)
            }
            
            for elementDict in response {
                if let element = try Element(from: elementDict) {
                    newArr.append(element)
                }
            }
        }
        catch let ParseError.results(json: json)  {
            print("Error encountered with parsing key for json object: \(json)")
        }
        catch let ParseError.image(image: im)  {
            print("Error encountered with parsing 'image': \(im)")
        }
        catch {
            print("Unknown parsing error")
        }

        
        return newArr
    }
}
