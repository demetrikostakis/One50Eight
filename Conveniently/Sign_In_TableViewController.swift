//
//  Sign_In_TableViewController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/1/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit


class Sign_In_TableViewController: UITableViewController {

    
    @IBOutlet weak var userPicker: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "Welcome!"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 1){
            return 3
        }
        return 1
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func signIn(){
        
        let predicate = NSPredicate(value: true)
        
        //checks to see what type of account the user wants to sign in to
        if userPicker!.selectedSegmentIndex == 1{
            
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let publicDB = appDel.publicDB
            
                let query = CKQuery(recordType: "Provider", predicate: predicate)
            
                publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {records, error in
                    
                    if error != nil{
                       
                        dispatch_sync(dispatch_get_main_queue(), {
                            
                            let alertController = UIAlertController(title: "Could Not Connect", message: "Please check your internet connection and try again", preferredStyle: .Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                        })

                    }else{
                        for record in records!{
                            if(record.objectForKey("password") as! String == self.passwordField.text! && record.objectForKey("username") as! String == self.usernameField.text!){
                                dispatch_sync(dispatch_get_main_queue(), {
                                    
                                    appDel.providerRecord = record
                                    print(appDel.providerRecord!)
                                    self.performSegueWithIdentifier("signInProvider", sender: self)
                                })
                                return
                            }
                        }
                        dispatch_sync(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "Incorrect Username or Password", message: "The username or password you have entered is incorrect", preferredStyle: .Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                        

                    }
                })
            
            
        }else{
            
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let publicDB = appDel.publicDB
            
            let query = CKQuery(recordType: "Client", predicate: predicate)
            publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {records, error in
                if error != nil{
                    dispatch_sync(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "Could Not Connect", message: "Please check your internet connection and try again", preferredStyle: .Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                    //print("Error in Request")
                    
                }else{
                    for record in records!{
                        if(record.objectForKey("password") as! String == self.passwordField.text! && record.objectForKey("username") as! String == self.usernameField.text!){
                            dispatch_sync(dispatch_get_main_queue(), {
                                
                                appDel.clientRecord = record
                                print(appDel.clientRecord)
                                self.performSegueWithIdentifier("signInClient", sender: self)
                            })
                            return
                        }
                    }
                    dispatch_sync(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "Incorrect Username or Password", message: "The username or password you have entered is incorrect", preferredStyle: .Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                    
                }
            })
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    

}
