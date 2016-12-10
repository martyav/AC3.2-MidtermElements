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
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    
    @IBOutlet weak var faveIt: UIButton!
    
    let postString = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    
    var chosenElement: Element?
    var element: Element!
    
    let baseImgString = "https://s3.amazonaws.com/ac3.2-elements/" // append symbol of element and .png to get the big version of the img. append the symbol, plus '_200' and '.png' to get the thumbnail version
    let bigSuffix = ".png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = chosenElement {
            self.title = element.name
            symbolLabel.text = "Symbol: " + element.symbol
            numberLabel.text = "Number: " + String(element.number)
            weightLabel.text = "Weight: " + String(element.weight)
            meltingLabel.text = "Melting point: " + String(element.melting) + " ℃"
            boilingLabel.text = "Boiling point: " + String(element.boiling) + " ℃"
            let url = URL(string: "https://s3.amazonaws.com/ac3.2-elements/" + element.symbol + bigSuffix)
            downloadImage(url: url!)
            self.element = element
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailToAlt" else { return }
        
        let destination = segue.destination as! AltDetailViewController
        destination.chosenElement = self.chosenElement
        destination.chosenPic = self.pic.image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func favoriteThis(_ sender: UIButton) {
        let data: [String: Any] = ["my_name": "Marty", "favorite_element": element.symbol]
    
        APIRequestManager.manager.postRequest(endPoint: postString, data: data)
    }
}

















