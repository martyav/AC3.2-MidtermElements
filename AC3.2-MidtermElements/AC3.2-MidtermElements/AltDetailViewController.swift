//
//  AltDetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/8/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class AltDetailViewController: UIViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var faveButton: UIButton!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shellLabel: UILabel!
    @IBOutlet weak var densityLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    @IBOutlet weak var kindAndGroup: UILabel!
    @IBOutlet weak var valenceLabel: UILabel!
    
    let postString = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    let baseImgString = "https://s3.amazonaws.com/ac3.2-elements/"
    let bigSuffix = ".png"
    
    var chosenElement: Element?
    var chosenPic: UIImage?
    var bgColor: UIColor?
    var fontColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            nameLabel.text = element.name.uppercased()
            numberLabel.text = String(element.number)
            weightLabel.text = String(element.weight)
            
            if element.group < 100 {
                kindAndGroup.text = "A group "  + String(element.group) + " \(element.kind)."
            } else {
                kindAndGroup.text = "A metal in the \(element.kind)." // elements in the lathanide/actinide series aren't numbered in the json data as you would expect
            }
            
            if element.valenceElectrons == nil {
                valenceLabel.text = "The number of valence electrons varies on context." // transition metal atoms vary in how many electrons they use when bonding with other atoms, due to their inner shells actually being involved in certain bonds. The internet says this has to do with quantum mechanics. I'm going to trust it.
            } else {
                if element.valenceElectrons! == 1 {
                    valenceLabel.text = "Has " + String(describing: element.valenceElectrons!) + "valence electron." // most elements behave as you'd think, though, following the octet rule you might have learned in high school
                } else {
                valenceLabel.text = "Has " + String(describing: element.valenceElectrons!) + " valence electrons."
                }
            }
            
            if element.melting != 0 {
                meltingLabel.text = "Melts at " + String(element.melting) + "℃."
            } else {
                meltingLabel.text = "Melting point unknown"
            }
            
            if element.boiling != 0 {
                boilingLabel.text = "Boils at " + String(element.boiling) + "℃."
            } else {
                boilingLabel.text = "Boiling point unknown"
            }
            
            if element.density != 0.00 {
                densityLabel.text = "Density of " + String(element.density) + "."
            } else {
                densityLabel.text = "Density unknown"
            }
            
            if element.discovery != "ancient" {
                discoveryLabel.text = "Discovered in " + element.discovery + "."
            } else {
                discoveryLabel.text = "Discovered in " + element.discovery + " times."
            }
            
            shellLabel.text = element.electrons
            let url = URL(string: baseImgString + element.symbol + bigSuffix)
            downloadImage(url: url!)
        }
        
        if let backgroundColor = bgColor,
            let textColor = fontColor {
            view.backgroundColor = backgroundColor
            view.tintColor = textColor
            nameLabel.textColor = textColor
            //nameLabel.shadowColor = backgroundColor
            numberLabel.textColor = textColor
            //numberLabel.shadowColor = backgroundColor
            shellLabel.textColor = textColor // textColor
            //shellLabel.shadowColor = backgroundColor
            weightLabel.textColor = textColor
            //weightLabel.shadowColor = backgroundColor
            faveButton.backgroundColor = textColor
            faveButton.setTitleColor(backgroundColor, for: .normal)
            
            kindAndGroup.textColor = textColor
            valenceLabel.textColor = textColor
            
            meltingLabel.textColor = textColor
            boilingLabel.textColor = textColor
            densityLabel.textColor = textColor
            discoveryLabel.textColor = textColor
            
            if let outlinedName = nameLabel as? UIOutlinedLabel { outlinedName.outlineColor = backgroundColor
            }
            if let outlinedNumber = numberLabel as? UIOutlinedLabel { outlinedNumber.outlineColor = backgroundColor
            }
            if let outlinedWeight = weightLabel as? UIOutlinedLabel { outlinedWeight.outlineColor = backgroundColor
            }
            if let outlinedShells = shellLabel as? UIOutlinedLabel { outlinedShells.outlineColor = backgroundColor
            }
        }
        
        if let image = chosenPic {
            pic.image = image
        }
    }
    
    func getDataFrom(url: URL, callback: @escaping (_ data: Data?, _ response: URLResponse?,  _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            callback(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFrom(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.pic.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func favoriteIt(_ sender: UIButton) {
        let data: [String: Any] = ["my_name": "Marty", "favorite_element": "My favorite element is \(nameLabel.text!.lowercased()). It is \(kindAndGroup.text!.lowercased())"]
        dump(data)
        APIRequestManager.manager.postRequest(endPoint: postString, data: data)
    }
}
