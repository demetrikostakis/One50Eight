//
//  SetRequestDate.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit
class SetRequestDate: UITableViewController {
    
    var requestRecord: CKRecord = CKRecord(recordType: "Request")

    var numRowsSectionOne: Int = 2
    var numRowsSectionTwo: Int = 1
    var startTapped = false
    var startTime: NSDate?
    var startTimeString: String?
    var endTime:NSDate?
    var endTimeString:String?
    
    var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextPage"))
        
        nextButton.enabled = false
        self.navigationItem.rightBarButtonItem = nextButton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextPage(){
        
        requestRecord.setObject(self.startTime, forKey: "timeOfRequest")
        performSegueWithIdentifier("findProviders", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return numRowsSectionOne
        default:
            return numRowsSectionTwo
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            if numRowsSectionOne == 2{
                switch indexPath.row{
                case 0:
                    let descriptionCell = tableView.dequeueReusableCellWithIdentifier("description", forIndexPath: indexPath)
                    return descriptionCell
                default:
                    let cell = tableView.dequeueReusableCellWithIdentifier("date", forIndexPath: indexPath)
                    cell.textLabel?.text = "Click to Set Date"
                    cell.detailTextLabel?.text = startTimeString
                    return cell
                }
            }else{
                if startTapped{
                    switch indexPath.row{
                    case 0:
                        let descriptionCell = tableView.dequeueReusableCellWithIdentifier("description", forIndexPath: indexPath)
                        return descriptionCell
                        
                    case 1:
                        let cell = tableView.dequeueReusableCellWithIdentifier("date", forIndexPath: indexPath)
                        cell.textLabel?.text = "Start"
                        cell.detailTextLabel?.text = startTimeString
                        return cell
                    default:
                        let cell = tableView.dequeueReusableCellWithIdentifier("expanded", forIndexPath: indexPath) as! SetDateCell
                        cell.startCell = true
                        cell.parentViewController = self
                        return cell
                    }

                }

            }
            
        
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("repeat", forIndexPath: indexPath)
        cell.textLabel?.text = "Repeat"
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            if (startTapped == false && indexPath.row == 1){
                
                
                startTapped = true
                numRowsSectionOne = 3
                let newIndexPath = NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .None)
                //self.tableView.reloadData()
                
            }else if(startTapped == true && indexPath.row == 1){
                
                
                startTapped = false
                numRowsSectionOne = 2
                let newIndexPath = NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section)
                self.tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
                
                
            }
            
        }else{
            self.performSegueWithIdentifier("showRepeat", sender: self)
        }
    
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if (startTapped && indexPath.row == 2){
                return 200
            }else if(indexPath.row == 0){
                return 107
            }
            return 44
        }
        return 44
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "findProviders"{
                let destinationVC = segue.destinationViewController as! providerMapResultTableView
                destinationVC.requestRecord = self.requestRecord
        }
        
    }

}
