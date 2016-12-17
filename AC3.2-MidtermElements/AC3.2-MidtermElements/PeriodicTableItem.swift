//
//  PeriodicTableItem.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class PeriodicTableItem: UIView {
    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var number: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let view = Bundle.main.loadNibNamed("PeriodicTableItem", owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.frame = self.bounds
        }
    }
}
