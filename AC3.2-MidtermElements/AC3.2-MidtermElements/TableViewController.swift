//
//  TableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marty Avedon on 12/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var elements = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The Elements"
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MyTableViewCell")
        
        getData()
    }
    
    func getData() {
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { data in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]),
                    let elements = jsonData as? [[String:Any]] {
                    
                    self.elements = Element.getElements(from: elements)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let element = self.elements[indexPath.row]
        cell.title?.text = element.name
        cell.backgroundPic?.image = nil
        cell.periodicView?.symbol.text = element.symbol
        cell.periodicView?.weight.text = String(element.weight)
        cell.periodicView?.number.text = String(element.number)
        
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png") { data in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.backgroundPic?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ElementViewController") as! ElementViewController
        
        controller.element = elements[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
