//
//  RepeatingRequestSetup.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class RepeatingRequestSetup: UITableViewController {
    
    var frequency: String = "Week"
    let week = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    let ordinalNums = ["First","Second","Third","Fourth","Fifth","Last"]
    
    let occurance = ["Weekly","Monthly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if frequency == "Weekly" && section == 1{
            return 7
        }
        return 2
        
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                cell.textLabel!.text = "Start"
                return cell

            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                cell.textLabel!.text = "End"
                return cell

            }
        case 1:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                cell.textLabel!.text = "Frequency"
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                cell.textLabel!.text = "Every"
                return cell
            }
        default:
            if frequency == "Weekly"{
                let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                cell.textLabel?.text = week[indexPath.row]
                return cell
            }else{
                switch indexPath.row{
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as! RepeatBasicCell
                    cell.textLabel!.text = "On the..."
                    return cell
                default:
                    let cell = tableView.dequeueReusableCellWithIdentifier("picker", forIndexPath: indexPath) as! RepeatPickerCell
                    cell.numComponents = 2
                    cell.componentOne = ordinalNums
                    cell.componentTwo = week
                    return cell
                }
            }
            
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 && indexPath.row == 1{
            return 200
        }
        else{
            return 44
        }
    }

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
