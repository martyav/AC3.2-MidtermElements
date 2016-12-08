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
    
    init(name: String, symbol:String, number:Int, weight: Double, melting: Int, boiling: Int) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.melting = melting
        self.boiling = boiling
    }
    
    convenience init?(from elementDict: [String:AnyObject]) {
        //var nameFromDict: String?
        //var symbolFromDict = "Unknown"
        //var numberFromDict = 0
        //var weightFromDict = 0.0
        //var meltingFromDict = 0
        //var boilingFromDict = 0
        
        guard let nameFromDict = elementDict["name"] as? String else { return nil }
        
        if let symbolFromDict = elementDict["symbol"] as? String,
            let numberFromDict = elementDict["number"] as? Int,
            let weightFromDict = elementDict["weight"] as? Double,
            let meltingFromDict = elementDict["melting_c"] as? Int,
            let boilingFromDict = elementDict["boiling_c"] as? Int {
        
            self.init(name: nameFromDict, symbol: symbolFromDict, number: numberFromDict, weight: weightFromDict, melting: meltingFromDict, boiling: boilingFromDict)
        } else {
            return nil // i want to do error checking for each key and add dummy values if any of them are empty but for now i just want to make sure this parsing actually goes through
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
