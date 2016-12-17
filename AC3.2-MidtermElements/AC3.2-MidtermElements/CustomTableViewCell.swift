//
//  CustomTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodicView: PeriodicTableItem!
    @IBOutlet weak var backgroundPic: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
