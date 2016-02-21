//
//  ProviderSideBar.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/5/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import MessageUI

class ProviderSideBar: UITableViewController, MFMailComposeViewControllerDelegate {

    let sideBarList = ["Payment","Contact Us","About Us","Facebook", "Twitter","Sign Out"]
    let imageList = [UIImage(imageLiteral: "bill_100px.png"),UIImage(imageLiteral: "message_100px.png"),UIImage(imageLiteral: "star_100px.png"),UIImage(imageLiteral: "facebook_100px.png"),UIImage(imageLiteral: "twitter_100px.png"),UIImage(imageLiteral: "return_100px.png")]
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sideBarList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = sideBarList[indexPath.row]
        cell.imageView?.image = imageList[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0){
            performSegueWithIdentifier("editPrices", sender: self)
        }
        if(indexPath.row == 2){
            UIApplication.sharedApplication().openURL(NSURL(string:"http://one50eight.com")!)
        }else if(indexPath.row == 1){
            let mailComposeViewController = self.configureMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }else{
                self.showSendMailErrorAlert()
            }
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func configureMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self //Extremely important to se the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["zacharyeliopoulos@yahoo.com"])
        mailComposerVC.setSubject("Conveniently Feedback")
        mailComposerVC.setMessageBody("Dear One50Eight,\n\nI would like to share the following feedback..\n Sent from Conveniently App", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        var sendMailErrorAlert: UIAlertController
        sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "There was an error sending this email. Please check your internet connection and try again.", preferredStyle: .Alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue{
        case MFMailComposeResultCancelled.rawValue:
            print("Canceled Mail")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
