//
//  RecentJobRequests.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/5/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class RecentJobRequests: UITableViewController {

    var clientRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!
    
    var requestRecords: [CKRecord]?
    
    var requestProvider: CKRecord?
    
    var selectedRequest: CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadData()

        //self.view.backgroundColor = UIColor.clearColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func downloadData(){
        
        let publicDB = (UIApplication.sharedApplication().delegate as! AppDelegate).publicDB
        
        let requestReference = CKReference(record: clientRecord, action: CKReferenceAction.DeleteSelf)
        
        let predicate = NSPredicate(value: true)
        
        let requestQuery = CKQuery(recordType: "Request", predicate: predicate)
        
        publicDB.performQuery(requestQuery, inZoneWithID: nil, completionHandler: {records, error in
            if error != nil{
                //error handling
            }else{
                var requests: [CKRecord] = []
                for record in records!{
                    if record.objectForKey("client") as! CKReference == requestReference{
                        requests.append(record)
                    }
                }
                dispatch_sync(dispatch_get_main_queue(), {
                    self.requestRecords = requests
                    self.tableView.reloadData()
                })
            }
            
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if requestRecords != nil{
            return (requestRecords!.count)
        }
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if requestRecords != nil{
            return 100
        }else{
            if indexPath.row == 0{
                return 312
            }else{
                return 100
            }
        }
        
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if requestRecords != nil{
            let _cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            
            return _cell
        }else{
            self.tableView.separatorColor = UIColor.clearColor()
            if indexPath.row == 0{
                let emptyArrayCell = tableView.dequeueReusableCellWithIdentifier("createRequest", forIndexPath: indexPath)
                return emptyArrayCell
            }else{
                let requestDescription = tableView.dequeueReusableCellWithIdentifier("requestDescription", forIndexPath: indexPath)
                
                return requestDescription

            }
        }
        

        // Configure the cell...

    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if requestRecords != nil{
            return "All Previous Service Requests"
        }else{
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let providerReference: CKReference = self.requestRecords![indexPath.row].objectForKey("provider") as! CKReference
        let requestProviderID = providerReference.recordID
        requestProvider = CKRecord(recordType: "Provider", recordID: requestProviderID)
        selectedRequest = self.requestRecords![indexPath.row]
        self.performSegueWithIdentifier("displayRequest", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayRequest"{
            let destinationVC = segue.destinationViewController as! Request
            destinationVC.providerRecord = self.requestProvider
            destinationVC.clientRecord = self.clientRecord
            destinationVC.requestRecord = selectedRequest
        }
    }

}
