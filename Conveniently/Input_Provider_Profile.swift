//
//  Update_Provider_Profile.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class Input_Provider_Profile: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var numberOfDaysSelected = [String]()

    var distances = ["1","2","3","4","5","10","20"]
    
    //all records that need to be saved
    var providerRecord: CKRecord?
    var scheduleRecords: [CKRecord] = []
    
    //All inputs from the tableview
    var services:[String] = []
    var weeklySchedule: [String] = []
    var startHours:[String] = []
    var endHours:[String] = []
    var maxDistance: String?
    
    //All cells in tableview
    var serviceSelector: Service_Selection_Cell?
    var scheduleEditor: Schedule_Editor_Cell?
    var dayEditor: Day_Editor_Cell?
    var setDistance: setDistanceCell?
    
    
    
    
    //All Interface Builder Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //set title of view
        
        
        let _signUp = UIBarButtonItem(title: "Sign Up", style: .Plain, target: self, action: "signUp")
        
        self.navigationItem.rightBarButtonItem = _signUp

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        scheduleRecords = []
        startHours = []
        endHours = []
    }
    
    
    func signUp(){
        
        let container: CKContainer = CKContainer.defaultContainer()
        let publicDB: CKDatabase = container.publicCloudDatabase
        
        
        services = serviceSelector?.serviceSelector.selectedSegmentTitles as! [String]
        weeklySchedule = scheduleEditor!.daySelector.selectedSegmentTitles as! [String]
        
        var count = 1
        for _ in weeklySchedule{
            
            let cell = self.tableView(self.tableView, cellForRowAtIndexPath: NSIndexPath(forItem: count, inSection: 1)) as! Day_Editor_Cell
            
            startHours.append(cell.startLabel.text!)
            endHours.append(cell.endLabel.text!)
            count = count + 1
        }
        
        maxDistance = setDistance?.distanceLabel.text
        
        //adds values to the provider record
        providerRecord?.setObject(services, forKey: "services")
        providerRecord?.setObject(maxDistance, forKey: "maxDistance")
        
        //creates the array of schedule records
        count = 0
        for day in weeklySchedule{
            
            //initalizes record
            let record = CKRecord(recordType: "Schedule")
            record.setObject(startHours[count], forKey: "startTime")
            record.setObject(endHours[count], forKey: "endTime")
            record.setObject(day, forKey: "day")
            
            //sets reference back to provider
            let providerReference = CKReference(record: providerRecord!, action: CKReferenceAction.DeleteSelf)
            record.setObject(providerReference, forKey: "provider")
            
            //adds record to array of schedule records
            scheduleRecords.append(record)
        }
        
        
        let batchSave = CKModifyRecordsOperation(recordsToSave: scheduleRecords, recordIDsToDelete: nil)
        batchSave.savePolicy = CKRecordSavePolicy.ChangedKeys
        batchSave.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error in
            if error != nil {
                print("Error saving records: \(error!.localizedDescription)")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertViewController = UIAlertController(title: "Error", message: "Error saving records: \(error!.localizedDescription)", preferredStyle: .Alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alertViewController, animated: true, completion: nil)
                })
                
            } else {
                print("Successfully saved records")
            }
        }
        
        publicDB.saveRecord(providerRecord!, completionHandler: {
            record, error in
            if error != nil{
                
                print("The Record DID NOT SAVE")
                
            }else{
                
                let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                appDel.providerRecord = record
                publicDB.addOperation(batchSave)
                appDel.schedule = self.scheduleRecords
                
                self.performSegueWithIdentifier("providerSignUp", sender: self)
                
            }
        })
        
    }
    
    //
    // MARK: - Table view data source
    //
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 1){
            return (numberOfDaysSelected.count + 1)
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0)){
            return 80

        }
        return 138
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            serviceSelector = tableView.dequeueReusableCellWithIdentifier("typeOfService", forIndexPath: indexPath) as? Service_Selection_Cell
            return serviceSelector!
        case 1:
            if(indexPath.row)==0{
                
                scheduleEditor = tableView.dequeueReusableCellWithIdentifier("addDays", forIndexPath: indexPath) as? Schedule_Editor_Cell
                scheduleEditor!.tableView = self.tableView
                scheduleEditor!.tableViewController = self
                return scheduleEditor!
                
            }else{
                dayEditor = tableView.dequeueReusableCellWithIdentifier("editDaySchedule", forIndexPath: indexPath) as? Day_Editor_Cell
                
                dayEditor!.dayLabel.text = self.numberOfDaysSelected[indexPath.row-1]
                
                return dayEditor!
            }
        case 2:
            setDistance = tableView.dequeueReusableCellWithIdentifier("distanceCell", forIndexPath: indexPath) as? setDistanceCell
            return setDistance!
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            return cell
        }
    }
    
   
    
      
    //
    // MARK: - PickerViewDataSource Implimentation
    //
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return distances[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distances.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //
    // MARK: - Navigation
    //
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


}
