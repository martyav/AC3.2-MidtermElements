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
    
    let baseImgString = "https://s3.amazonaws.com/ac3.2-elements/" // append symbol of element and .png to get the big version of the img. append the symbol, plus '_200' and '.png' to get the thumbnail version
    let bigSuffix = ".png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            nameLabel.text = element.name
            //symbolLabel.text = element.symbol
            numberLabel.text = String(element.number)
            weightLabel.text = String(element.weight)
            let url = URL(string: "https://s3.amazonaws.com/ac3.2-elements/" + element.symbol + bigSuffix)
            downloadImage(url: url!)
        }
    }
    
    //    APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/" + "\(chosenElement!.symbol)" + bigSuffix) { (data: Data?) in
    //        if let validData = data,
    //    let validImage = UIImage(data: validData) {
    //    DispatchQueue.main.async {
    //    pic.imageView?.image = validImage
    //    pic.setNeedsLayout()
    //    }
    //    }
    //    }
    
    // ok, i am scriptkiddying this rn because i just want images to work.
    // from: https://github.com/martyav/basicSeguesAndImageLoading
    
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
                // set a remote image for a normal image view
                self.pic.image = UIImage(data: data)
            }
        }
    }
}
