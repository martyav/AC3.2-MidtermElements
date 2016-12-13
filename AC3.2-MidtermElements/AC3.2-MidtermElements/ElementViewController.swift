//
//  ElementViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Jason Gresh on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    var element: Element!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = element.name

        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol).png") { data in
            if let validData = data,
                let image = UIImage(data: validData) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        postData()
    }
    
    func postData() {
        let favorite = ["my_name" : "Jason Gresh", "favorite_element" : element.symbol]
        
        APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", data: favorite)
    }
}
