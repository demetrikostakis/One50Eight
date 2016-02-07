//
//  Update_Provider_Profile.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class Input_Provider_Profile: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var numberOfDaysSelected = [String]()

    var distances = ["1","2","3","4","5","10","20"]
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var nextButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.clearColor()
        self.navigationItem.title = "Setup"
        
        nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("nextPage"))
        self.navigationItem.rightBarButtonItem = nextButton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextPage(){
        performSegueWithIdentifier("next", sender: self)
    }

    // MARK: - Table view data source

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
            let serviceSelector = tableView.dequeueReusableCellWithIdentifier("typeOfService", forIndexPath: indexPath) as! Service_Selection_Cell
            return serviceSelector
        case 1:
            if(indexPath.row)==0{
                
                let scheduleEditor = tableView.dequeueReusableCellWithIdentifier("addDays", forIndexPath: indexPath) as! Schedule_Editor_Cell
                scheduleEditor.tableView = self.tableView
                scheduleEditor.tableViewController = self
                return scheduleEditor
                
            }else{
                let dayEditor = tableView.dequeueReusableCellWithIdentifier("editDaySchedule", forIndexPath: indexPath) as! Day_Editor_Cell
                
                dayEditor.dayLabel.text = self.numberOfDaysSelected[indexPath.row-1]
                
                return dayEditor
            }
        case 2:
            let maxDistance = tableView.dequeueReusableCellWithIdentifier("distanceCell", forIndexPath: indexPath) as! setDistanceCell
            return maxDistance
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            return cell
        }
    }
    
   
    
      
    
    //PickerViewDataSource Implimentation
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return distances[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distances.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //ScrollViewDelegate functions
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
