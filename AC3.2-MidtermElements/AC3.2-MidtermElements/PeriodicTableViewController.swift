//
//  PeriodicTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/8/16.
//  Copyright © 2016 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class PeriodicTableViewController: UITableViewController {
    
    let getString = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    let postString = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    
    let baseImgString = "https://s3.amazonaws.com/ac3.2-elements/" // append symbol of element and .png to get the big version of the img. append the symbol, plus '_200' and '.png' to get the thumbnail version
    let bigSuffix = ".png"
    let thumbSuffix = "_200.png"
    
    var elements: [Element]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getData(endPoint: getString) { (data: Data?) in
            if let validData = data,
                let elementArr = Element.createElementArr(from: validData) {
                self.elements = elementArr
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
        /*
         let escapedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
         APIRequestManager.manager.getData(endPoint: "https://api.spotify.com/v1/search?q=\(escapedString!)&type=album&limit=50") { (data: Data?) in
         if  let validData = data,
         let validAlbums = Album.albums(from: validData) {
         self.albums = validAlbums
         DispatchQueue.main.async {
         self.tableView?.reloadData()
         }
         }
         }
         */
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfCells = elements?.count ?? 0
        return numOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Atom", for: indexPath)
        
        // get a reference to the album in question
        let thisParticularElement = elements?[indexPath.row]
        
        // set the name
        cell.textLabel?.text = thisParticularElement?.name
        // set the subtitle
        if let unwrappedSymbol = thisParticularElement?.symbol,
            let unwrappedNumber = thisParticularElement?.number,
            let unwrappedWeight = thisParticularElement?.weight {
            cell.detailTextLabel?.text = "\(unwrappedSymbol)(\(unwrappedNumber)) \(unwrappedWeight)"
        }
            
        // reset the image to nil
        cell.imageView?.image = nil
        
        // make the call to get the correct image
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/" + "\(thisParticularElement!.symbol)" + thumbSuffix) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.imageView?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }
        
        /*
         func downloadImage(url: URL) {
         print("Download Started")
         getDataFrom(url: url) { (data, response, error)  in
         guard let data = data, error == nil else { return }
         print(response?.suggestedFilename ?? url.lastPathComponent)
         print("Download Finished")
         DispatchQueue.main.async() { () -> Void in
         // set a remote image for a normal image view
         self.photo.image = UIImage(data: data)
         // set a remote image for the background of a button -- this is useful for when we want to make clickable images, because making image views clickable is kind of a hack and not good for screen readers
         self.clickableImg.setBackgroundImage(UIImage(data: data), for: .normal)
         }
         }
         }
        */
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "cellToDetail" else { return }
        
        let destination = segue.destination as! DetailViewController
        let cell = sender as? UITableViewCell
        if let indexPath = tableView.indexPath(for: cell!) {
            destination.chosenElement = elements?[indexPath.row]
            destination.chosenElementsPic = cell!.imageView?.image
        }
    }
    
}
