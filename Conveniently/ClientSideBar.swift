//
//  ClientSideBar.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/5/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import MessageUI

class ClientSideBar: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let sideBarList = ["Join Our Team","Payment","Contact Us","About Us","Facebook", "Twitter","Sign Out"]
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

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 3){
            UIApplication.sharedApplication().openURL(NSURL(string:"http://one50eight.com")!)
        }else if(indexPath.row == 2){
            let mailComposeViewController = self.configureMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }else{
                self.showSendMailErrorAlert()
            }
        }else if(indexPath.row == 6){
            let alertController = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: UIAlertControllerStyle.Alert)
            let signOut = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { alert in
                
                self.performSegueWithIdentifier("clientSignOut", sender: self)
                
            })
            let cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alertController.addAction(signOut)
            alertController.addAction(cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func configureMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self //Extremely important to se the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["contact_us@one50eight.com"])
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
