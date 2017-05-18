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
            numberLabel.text = String(element.number)
            weightLabel.text = String(element.weight)
            
            shellLabel.text = element.electrons
            
            kindAndGroup.text = element.group < 100 ? "\(element.name.capitalized) is a group \(element.group) \(element.kind)." : "\(element.name.capitalized) is a  metal in the \(element.kind)." // elements in the lathanide/actinide series aren't numbered in the json data as you would expect
            valenceLabel.text = element.valenceElectrons == nil ? "The number of valence electrons varies on context." : element.valenceElectrons! == 1 ? "It has \(element.valenceElectrons!) valence electron." : "It has \(element.valenceElectrons!) valence electrons."
            boilingLabel.text = element.boiling != nil ? "It boils at \(element.boiling!) ℃." : "Its boiling point is unknown."
            meltingLabel.text = element.melting != nil ? "It melts at \(element.melting!) ℃." : "Its melting point is unknown."
            densityLabel.text = element.density != nil ? "\(element.name.capitalized) has a density of \(element.density!) kg/m\u{00B3}." : "Its density is unknown."
            
            discoveryLabel.text = element.discovery != "ancient" ? "Discovered in \(element.discovery)." : "Discovered in ancient times."
            
            let url = URL(string: baseImgString + element.symbol + bigSuffix)
            
            downloadImage(url: url!)
        }
        
        if let backgroundColor = bgColor,
            let textColor = fontColor {
            self.navigationController?.navigationBar.tintColor = .black
            
            view.backgroundColor = backgroundColor
            view.tintColor = textColor
            
            numberLabel.textColor = textColor
            shellLabel.textColor = textColor
            weightLabel.textColor = textColor
            faveButton.backgroundColor = textColor
            faveButton.setTitleColor(backgroundColor, for: .normal)
            
            kindAndGroup.textColor = textColor
            valenceLabel.textColor = textColor
            
            meltingLabel.textColor = textColor
            boilingLabel.textColor = textColor
            densityLabel.textColor = textColor
            discoveryLabel.textColor = textColor
            
            if let outlinedNumber = numberLabel as? UIOutlinedLabel,
                let outlinedWeight = weightLabel as? UIOutlinedLabel,
                let outlinedShells = shellLabel as? UIOutlinedLabel {
                    outlinedNumber.outlineColor = backgroundColor
                    outlinedWeight.outlineColor = backgroundColor
                    outlinedShells.outlineColor = backgroundColor
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
        let data: [String: Any] = ["my_name": "Marty", "favorite_element": "My favorite element is \(chosenElement?.name). It is \(kindAndGroup.text!.lowercased())"]
        dump(data)
        APIRequestManager.manager.postRequest(endPoint: postString, data: data)
    }
}
