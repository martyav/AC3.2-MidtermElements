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
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shellLabel: UILabel!
    @IBOutlet weak var densityLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    
    var chosenElement: Element?
    var chosenPic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            nameLabel.text = element.name
            //symbolLabel.text = element.symbol
            numberLabel.text = String(element.number)
            weightLabel.text = String(element.weight)
            meltingLabel.text = String(element.melting)
            boilingLabel.text = String(element.boiling)
            densityLabel.text = String(element.density)
            discoveryLabel.text = element.discovery
            shellLabel.text = element.electrons
            
//            switch element.group {
//            case 1:
//                self.view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
//            case 2:
//                self.view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0, alpha: 1)
//            default:
//                self.view.backgroundColor = .white
//            }
        }
        
        if let image = chosenPic {
            pic.image = image
        }
    }
}
