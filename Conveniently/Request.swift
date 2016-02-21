//
//  Request.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/6/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import MapKit

class Request: UITableViewController, UITextFieldDelegate, UINavigationBarDelegate{
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var providerName: UITextField!
    @IBOutlet weak var providerRating: UILabel!
    @IBOutlet weak var providerProfilePicture: UIImageView!
    
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientProfilePicture: UIImageView!
    
    @IBOutlet weak var addressField: standardCell!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var typeOfService: UITextField!
    
    @IBOutlet weak var timeOfRequest: UITextField!
    
    
    
    
    //returns view to the original viewController when done
    
    @IBAction func back(sender: UIBarButtonItem!){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.title = "Service Request"
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    //hides status bar when not in editing mode
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
