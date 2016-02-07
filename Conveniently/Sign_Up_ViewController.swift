//
//  Sign_Up_ViewController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/1/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit


class Sign_Up_ViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var userTypePicker: UISegmentedControl!
    @IBOutlet weak var enterUsernameField: UITextField!
    @IBOutlet weak var enterPasswordField: UITextField!
    @IBOutlet weak var enterEmailField: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    var userRecord: CKRecord?
    var clientRecord: CKRecord?
    var providerRecord: CKRecord?

    let states = ["Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
        "Colorado",
        "Connecticut",
        "Delaware",
        "Florida",
        "Georgia",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.clearColor()
        self.navigationItem.title = "Sign Up"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let nextButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextPage")
        
        self.navigationItem.rightBarButtonItem = nextButton

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //call this function when a tap outside of keyboard is recognized
    
    //Makes sure keyboard dismisses on return key
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return 8
    }
    
    func nextPage(){
        
        //add attributes to the record
        userRecord = CKRecord(recordType: "User")
        userRecord?.setObject(enterUsernameField.text, forKey: "username")
        userRecord?.setObject(enterPasswordField.text, forKey: "password")
        userRecord?.setObject(confirmEmail.text, forKey: "email")
        
        print(userRecord)
        
        let address = zipCodeField.text!
        
        //creates location object from address
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {placemarks,error in
            if placemarks?.count > 0{
                
                let placemark = placemarks?.first
                let location = placemark?.location
                self.userRecord?.setObject(location, forKey: "address")
                print("WE DID IT")
            }
        })
        
        
        if userTypePicker!.selectedSegmentIndex == 0{
            
            providerRecord = CKRecord(recordType: "Provider")
            
            performSegueWithIdentifier("setUpProvider", sender: self)
            
        }else{
            
            clientRecord = CKRecord(recordType: "Client")
            
            performSegueWithIdentifier("setUpClient", sender: self)
            
        }
    }


    //PickerView Implementation
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "setUpClient"{
            
            let signupVC = segue.destinationViewController as! Input_Client_Profile
            signupVC.userRecord = self.userRecord
            
        }else{
            
            let signupVC = segue.destinationViewController as! Input_Provider_Profile
            signupVC.userRecord = self.userRecord
            
        }
        
        
        
    }
    

}
