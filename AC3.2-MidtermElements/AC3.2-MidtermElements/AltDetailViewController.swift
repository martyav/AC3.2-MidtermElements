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
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var chosenElement: Element?
    var chosenPic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            nameLabel.text = element.name
            //symbolLabel.text = element.symbol
            numberLabel.text = String(element.number)
            weightLabel.text = String(element.weight)
        }
        
        if let image = chosenPic {
            pic.image = image
        }
    }
}
