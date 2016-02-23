//
//  ClientProfileMain.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/4/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit
import CoreLocation

class ClientProfileMain: UITableViewController {

    var clientRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!
    
    var addressString = ""
    
    @IBOutlet weak var profilePicture: UIImageView!

    @IBOutlet var viewWIthButtons: UIView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var personalSelected: Bool = false
    var paymentSelected: Bool = false
    var yardSelected: Bool = true
    
    //navBar button functions to switch views
    @IBAction func showPersonal(sender: AnyObject) {
        personalSelected = true
        paymentSelected = false
        yardSelected = false
        let location = self.clientRecord.objectForKey("address") as! CLLocation
        let geocoder: CLGeocoder = CLGeocoder()
        
        
            geocoder.reverseGeocodeLocation(location, completionHandler: {placemark,error in
                if error != nil{
                    print("there was an error reverse geolocating the location")
                }else{
                    let _placemark = placemark?.last
                    self.addressString = "\(_placemark!.subThoroughfare!) \(_placemark!.thoroughfare!) \(_placemark!.locality!), \(_placemark!.administrativeArea!)"
                    self.tableView.reloadData()
                }
            })
        

    }
    @IBAction func showPayment(sender: AnyObject) {
        paymentSelected = true
        yardSelected = false
        personalSelected = false
        self.tableView.reloadData()
    }
    @IBAction func showYard(sender: AnyObject) {
        yardSelected = true
        personalSelected = false
        paymentSelected = false
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2
        self.profilePicture.clipsToBounds = true

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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(yardSelected){
            return 2
        }else if(personalSelected){
            return 4
        }else{
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(yardSelected){
            return 2
        }else if(personalSelected){
            switch section{
            case 0:
                return 2
            case 1:
                return 2
            case 2:
                return 1
            default:
                return 1
            }
        }else{
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(yardSelected){
            
            switch indexPath.section{
            case 0:
                if indexPath.row == 0{
                    let cell = tableView.dequeueReusableCellWithIdentifier("aboutSizes", forIndexPath: indexPath)
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCellWithIdentifier("sizes", forIndexPath: indexPath) as! Profile_YardAndDrivewaySizeTableViewCell
                    return cell
                }
            default:
                if indexPath.row == 0{
                    let cell = tableView.dequeueReusableCellWithIdentifier("aboutRadius", forIndexPath: indexPath)
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCellWithIdentifier("radius", forIndexPath: indexPath) as! Profile_MaxDistanceTableViewCell
                    return cell
                }
            }
            
        }else if(personalSelected){
            let cell = tableView.dequeueReusableCellWithIdentifier("standard", forIndexPath: indexPath) as! standardCell
            
            switch indexPath.section{
            case 0:
                switch indexPath.row{
                case 0:
                    cell.label?.text = "username"
                    cell.textField.text = self.clientRecord.objectForKey("username") as? String

                default:
                    cell.label?.text = "password"
                    cell.textField.text = self.clientRecord.objectForKey("password") as? String

                }
            case 1:
                switch indexPath.row{
                case 0:
                    cell.label?.text = "First"
                    cell.textField.text = self.clientRecord.objectForKey("firstName") as? String

                default:
                    cell.label?.text = "Last"
                    cell.textField.text = self.clientRecord.objectForKey("lastName") as? String

                }
            case 2:
                cell.label?.text = "Email"
                cell.textField.text = self.clientRecord.objectForKey("email") as? String
            default:
                cell.label?.text = "Address"
                cell.textField.text = addressString
            }
            return cell
        }else{
            
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(yardSelected){
            if indexPath.section == 0{
                if indexPath.row == 0{
                    return 170
                }else{
                    return 236
                }
            }else{
                if indexPath.row == 0{
                    return 100
                }else{
                    return 130
                }
            }

        }else if(personalSelected){
            return 80
        }else{
            return 44
        }
        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if(yardSelected){
            switch section{
            case 0:
                return "About your Property Sizes"
            default:
                return "About Your Maximum Radius"
            }
        }else if(personalSelected){
            switch section{
            case 0:
                return "Username"
            case 1:
                return "Your Name"
            case 2:
                return "Your Email"
            default:
                return "Your Address"
            }

        }else{
            return ""
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
