//
//  ViewController.swift
//  MK-App
//
//  Created by Max Gao on 16.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var switchButton: UIButton!

    var entfall = [Entfall]()
    var vertretung = [Vertretung]()
    
    var all = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Morgen"
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        if(all.count == 0) {
            
            
            all.append("---")
            
        }
        
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
    
        if(self.title == "Morgen") {
            entfall.removeAll()
            vertretung.removeAll()
            all.removeAll()
         
            self.title = "Heute"
            self.tableView.reloadData()
        } else {
            entfall.removeAll()
            vertretung.removeAll()
            all.removeAll()
            
            self.tableView.reloadData()
            self.title = "Morgen"
        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "Cell"
        if let cell = self.tableView!.dequeueReusableCellWithIdentifier(cellIdentifier)! as? DataCell {

             var data = all[indexPath.row]
                
             cell.label.text = data.componentsSeparatedByString("tsep").joinWithSeparator(" ")
            
                
            

            
            
            return cell
            
            
        } else {
            return DataCell()
        }
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return all.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
