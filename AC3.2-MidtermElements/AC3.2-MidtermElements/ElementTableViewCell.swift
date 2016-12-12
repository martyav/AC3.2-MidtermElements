//
//  ElementTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/10/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
