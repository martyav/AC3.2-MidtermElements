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
    
    let baseImgString = "https://s3.amazonaws.com/ac3.2-elements/" // append symbol of element and .png to get the big version of the img. append the symbol, plus '_200' and '.png' to get the thumbnail version
    let thumbSuffix = "_200.png"
    
    var elements: [Element]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breaking Bad Chemistry Set"
        
        APIRequestManager.manager.getData(endPoint: getString) { (data: Data?) in
            if let validData = data,
                let elementArr = Element.createElementArr(from: validData) {
                self.elements = elementArr
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfCells = elements?.count ?? 0
        return numOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ElementTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Atom", for: indexPath) as! ElementTableViewCell
        
        // get a reference to the album in question
        let thisParticularElement = elements?[indexPath.row]
        // alternate cell colors
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.name?.textColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
            cell.details?.textColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)

        } else {
            cell.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
            cell.name?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.details?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        // set the name
        cell.name?.text = thisParticularElement?.name.uppercased()
        
        // set the subtitle
        if let unwrappedSymbol = thisParticularElement?.symbol,
            let unwrappedNumber = thisParticularElement?.number,
            let unwrappedWeight = thisParticularElement?.weight {
            cell.details?.text = "\(unwrappedSymbol)(\(unwrappedNumber)) \(unwrappedWeight)"
        }
            
        // reset the image to nil
        cell.bgImage?.image = nil
        
        // make the call to get the correct image
        APIRequestManager.manager.getData(endPoint: baseImgString + "\(thisParticularElement!.symbol)" + thumbSuffix) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.bgImage?.image = validImage
                    cell.bgImage?.alpha = 0.3
                    cell.bgImage?.layer.masksToBounds = true
                    cell.setNeedsLayout()
                }
            }
        }

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "cellToDetail" else { return }
        
        let destination = segue.destination as! AltDetailViewController
        let cell = sender as? UITableViewCell
        if let indexPath = tableView.indexPath(for: cell!) {
            destination.chosenElement = elements?[indexPath.row]
        }
        
        if let unwrappedCell = cell as? ElementTableViewCell {
            destination.bgColor = unwrappedCell.backgroundColor
            destination.fontColor = unwrappedCell.name?.textColor
        }
    }
    
}
