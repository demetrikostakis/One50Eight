//
//  ProviderProfileMain.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/5/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import QuartzCore
import CloudKit

class ProviderProfileMain: UITableViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var providerRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).providerRecord!
    var scheduleRecords: [CKRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadData()
        //print(providerRecord)
        //print(scheduleRecords)
        
        
        nameLabel.text = "\(providerRecord.objectForKey("firstName") as! String) \(providerRecord.objectForKey("lastName") as! String)"
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
        self.profilePicture.clipsToBounds = true
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Download user data
    
    func downloadData(){
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let publicDB = appDel.publicDB
        
        let record = self.providerRecord
        
        let scheduleReference = CKReference(record: record, action: CKReferenceAction.DeleteSelf)
        
        let predicate = NSPredicate(value: true)
        
        let scheduleQuery = CKQuery(recordType: "Schedule", predicate: predicate)
        
        //performs a query to find the schedules connected with this provider
        publicDB.performQuery(scheduleQuery, inZoneWithID: nil, completionHandler: {
            records, error in
            if error != nil{
                print("error recieving schedule records")
            }else{
                dispatch_sync(dispatch_get_main_queue(), {
                    for record in records!{
                        if record.objectForKey("provider") as! CKReference == scheduleReference{
                            
                            print("there is a schedule record here")
                            self.scheduleRecords.append(record)
                            
                        }
                    }
                    self.tableView.reloadData()
                })
                
            }
        })

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section{
            
        case 0:
            return 1
        case 1:
            
            if(providerRecord.objectForKey("prices") != nil){
                return (providerRecord.objectForKey("prices") as! [String]).count
            }
            
            return 1
        default:
            return scheduleRecords.count
        }

    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Services Offered"
            
        }else if(section == 1){
            return "Prices"
        }
        return "Schedule"
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            var cell: UITableViewCell?
        
        switch indexPath.section{
            
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("services", forIndexPath: indexPath)
            return cell!
        case 1:
            let pricecell = tableView.dequeueReusableCellWithIdentifier("prices", forIndexPath: indexPath) as! providerPriceCell
            if(providerRecord.objectForKey("prices") != nil){
                pricecell.priceLabel.text = "\((providerRecord.objectForKey("prices") as! [String])[indexPath.row]))"
            }
            return pricecell
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("schedule", forIndexPath: indexPath)
            return cell!
        }

        
        }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
            
        case 0:
            return 120
        case 1:
            return 46
        default:
            return 44
        }

    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
