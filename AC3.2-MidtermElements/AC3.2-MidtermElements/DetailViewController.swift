//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/8/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var ifPicIsNotAvailable: UILabel!
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    
    @IBOutlet weak var faveIt: UIButton!
    
    var chosenElement: Element?
    var chosenElementsPic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            self.title = element.name
            symbolLabel.text = "Symbol: " + element.symbol
            numberLabel.text = "Number: " + String(element.number)
            weightLabel.text = "Weight: " + String(element.weight)
            meltingLabel.text = "Melting point: " + String(element.melting) + " ℃"
            boilingLabel.text = "Boiling point: " + String(element.boiling) + " ℃"
        }
        
        if chosenElementsPic != nil {
            pic.image = chosenElementsPic
        } else {
            pic.backgroundColor = .black
            ifPicIsNotAvailable.text = "?"
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
