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
    
    let postString = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    var chosenElement: Element?
    var chosenPic: UIImage?
    var bgColor: UIColor?
    var fontColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            nameLabel.text = element.name
            //symbolLabel.text = element.symbol
            numberLabel.text = String(element.number)
            weightLabel.text = "Atomic weight: " + String(element.weight)
            meltingLabel.text = "Melts: " + String(element.melting) + "℃"
            boilingLabel.text = "Boils: " + String(element.boiling) + "℃"
            densityLabel.text = "Density: " + String(element.density)
            if element.discovery != "ancient" {
                discoveryLabel.text = "Discovered in " + element.discovery
            } else {
                discoveryLabel.text = "Discovered in " + element.discovery + " times"
            }
            shellLabel.text = "Electron configuration: " + element.electrons
        }
        
        if let backgroundColor = bgColor,
            let textColor = fontColor {
            view.backgroundColor = backgroundColor
            view.tintColor = textColor
            nameLabel.textColor = textColor
            nameLabel.shadowColor = backgroundColor
            numberLabel.textColor = textColor
            numberLabel.shadowColor = backgroundColor
            weightLabel.textColor = textColor
            meltingLabel.textColor = textColor
            boilingLabel.textColor = textColor
            densityLabel.textColor = textColor
            discoveryLabel.textColor = textColor
            shellLabel.textColor = textColor
            faveButton.tintColor = textColor
            faveButton.setTitleShadowColor(backgroundColor, for: .normal)
        }
        
        if let image = chosenPic {
            pic.image = image
        }
    }
    
    @IBAction func favoriteIt(_ sender: UIButton) {
        let data: [String: Any] = ["my_name": "Marty", "favorite_element": chosenElement!.symbol]
        APIRequestManager.manager.postRequest(endPoint: postString, data: data)
    }
}
