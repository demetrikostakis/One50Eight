//
//  Sign_Up_ViewController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/1/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit
import MapKit


class Sign_Up_ViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var userTypePicker: UISegmentedControl!
    @IBOutlet weak var enterUsernameField: UITextField!
    @IBOutlet weak var enterPasswordField: UITextField!
    @IBOutlet weak var enterEmailField: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
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
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        switch section{
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 1
            
        }
    }
    
    func nextPage(){
        
        if (enterUsernameField.text?.characters.count < 7)||(enterPasswordField.text?.characters.count < 7){
            let alertVC = UIAlertController(title: "Incomplete", message: "Please complete all fields to proceed", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertVC, animated: true, completion: nil)
            return
        }

        if userTypePicker!.selectedSegmentIndex == 0{
            
            //add attributes to the record
            providerRecord = CKRecord(recordType: "Provider")
            
            providerRecord?.setObject(enterUsernameField.text!, forKey: "username")
            providerRecord?.setObject(enterPasswordField.text!, forKey: "password")
            providerRecord?.setObject(firstNameField.text!, forKey: "firstName")
            providerRecord?.setObject(lastNameField.text!, forKey: "lastName")
            providerRecord?.setObject(confirmEmail.text, forKey: "email")
            let address = addressField.text!
            
            
            //creates location object from address
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {placemarks,error in
                if placemarks?.count > 0{
                    
                    let placemark = placemarks?.first
                    let location = placemark?.location
                    self.providerRecord?.setObject(location, forKey: "address")
                }
            })
    
        performSegueWithIdentifier("setUpProvider", sender: self)
            
        }else{
            
            clientRecord = CKRecord(recordType: "Client")
        
            clientRecord?.setObject(enterUsernameField.text, forKey: "username")
            clientRecord?.setObject(enterPasswordField.text, forKey: "password")
            clientRecord?.setObject(firstNameField.text!, forKey: "firstName")
            clientRecord?.setObject(lastNameField.text!, forKey: "lastName")
            clientRecord?.setObject(confirmEmail.text, forKey: "email")
            
            let address = addressField.text!
            
            
            //creates location object from address
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {placemarks,error in
                if placemarks?.count > 0{
                    
                    let placemark = placemarks?.first
                    let location = placemark?.location
                    self.clientRecord?.setObject(location, forKey: "address")
                }
            })

            
            
            performSegueWithIdentifier("setUpClient", sender: self)
            
        }
    }
    
    
    
    func searchForAddress(_address: String) -> CLLocation{
        
        var location: CLLocation?
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = _address
        let localSearch = MKLocalSearch(request: localSearchRequest)
        
        dispatch_sync(dispatch_get_main_queue(), {
            localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
                
                if localSearchResponse == nil{
                    let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                }
                
                location = CLLocation(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            }

        })
        
        return location!
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
            signupVC.clientRecord = self.clientRecord!
            
        }else{
            
            let signupVC = segue.destinationViewController as! Input_Provider_Profile
            signupVC.providerRecord = self.providerRecord!
            
        }
        
        
        
    }
    

}
