//
//  ProviderPayment.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/6/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class ProviderPayment: UITableViewController {

    var providerRecord: CKRecord?
    var scheduleRecords: [CKRecord]?
    
    @IBOutlet weak var finishButton: UIButton!
    var yardSizes = ["0.1","0.5","1","1.5","2","2.5","3+"]
    var drivewaySizes = ["10 x 10","20 x 10","20 x 20","30 x 20","30 x 30","+30 x +30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setup Payment"

        if(self.navigationController == nil){
            finishButton.setTitle("Save", forState: .Normal)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return yardSizes.count
        default:
            return drivewaySizes.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! standardCell
        
        switch indexPath.section{
        case 0:
            cell.label.text = "Price for " + yardSizes[indexPath.row] + " Acres"
        default:
            cell.label.text = "Price for " + drivewaySizes[indexPath.row] + " Square Feet"
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0:
            return "Lawn Services"
        default:
            return "Snow Services"
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
