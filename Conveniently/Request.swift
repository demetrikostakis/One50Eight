//
//  Request.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/6/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import MapKit
import CloudKit
import CoreLocation

class Request: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var clientRecord: CKRecord!
    var providerRecord: CKRecord!
    var requestRecord: CKRecord!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var providerName: UITextField!
    @IBOutlet weak var providerRating: UILabel!
    @IBOutlet weak var providerProfilePicture: UIImageView!
    
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientProfilePicture: UIImageView!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var typeOfService: UITextField!
    
    @IBOutlet weak var timeOfRequest: UITextField!

    @IBOutlet weak var servicePicker: UIPickerView!
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    var finishButton: UIBarButtonItem!
    
    var address: CLLocation!
    var clientReference: CKReference!
    var providerReference: CKReference!
    var scheduledService: String!
    var price: Int = 0
    var serviceDate: NSDate!
    
    
    
    //returns view to the original viewController when done
    
    
    func confirmRequest(){
        let alertController = UIAlertController(title: "Confirm Request", message: "Are you ready to finish and send this service request?", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: ({action in
            
            self.requestRecord.setObject(self.address, forKey: "address")
            self.requestRecord.setObject(self.clientReference, forKey: "client")
            self.requestRecord.setObject(self.providerReference, forKey: "provider")
            self.requestRecord.setObject(self.scheduledService, forKey: "service")
            self.requestRecord.setObject(self.price, forKey: "price")
            
            
                let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                let publicDB = appDel.publicDB
                publicDB.saveRecord(self.requestRecord, completionHandler: {record,error in
                    if error != nil{
                        let alertController = UIAlertController(title: "Could Not Complete Request", message: "There was an error completing your request. please check your internet connection and try again", preferredStyle: .Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), {
                            self.performSegueWithIdentifier("finishRequest", sender: self)
                        })
                    }
            })
            
            
        })))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton = UIBarButtonItem(title: "Finish", style: .Plain, target: self, action: Selector("confirmRequest"))
        self.navigationItem.rightBarButtonItem = finishButton
        self.title = "Service Request"
        
        self.clientName.text = "\(clientRecord.objectForKey("firstName") as! String) \(clientRecord.objectForKey("lastName") as! String))"
        
        self.providerName.text = "\(providerRecord.objectForKey("firstName") as! String) \(providerRecord.objectForKey("lastName") as! String))"
        
        let location = self.clientRecord.objectForKey("address") as! CLLocation
        let geocoder: CLGeocoder = CLGeocoder()
        
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let viewRegion = MKCoordinateRegionMakeWithDistance(locationCoordinate2D, 500, 500)
        self.map.setRegion(viewRegion, animated: false)
        geocoder.reverseGeocodeLocation(location, completionHandler: {placemark,error in
            if error != nil{
                print("there was an error reverse geolocating the location")
            }else{
                let _placemark = placemark?.last
                self.addressField.text = "\(_placemark!.subThoroughfare!) \(_placemark!.thoroughfare!) \(_placemark!.locality!), \(_placemark!.administrativeArea!)"
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                self.map.addAnnotation(annotation)
            }
        })
        
        serviceDate = self.requestRecord.objectForKey("timeOfRequest") as! NSDate
        
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMMM  hh:mm a"
        let serviceDateString = dateFormatter.stringFromDate(self.serviceDate)
        
        timeOfRequest.text = serviceDateString
        
        serviceLabel.text = (providerRecord.objectForKey("services") as! [String])[0]
        
        priceField.text = String(price)
        
        
        address = location
        clientReference = CKReference(record: clientRecord, action: .DeleteSelf)
        providerReference = CKReference(record: providerRecord, action: .DeleteSelf)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Picker view data source
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return (providerRecord.objectForKey("services") as! [String])[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return (providerRecord.objectForKey("services") as! [String]).count
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.serviceLabel.text = pickerView(_pickerView, titleForRow: row, forComponent: component)
        self.scheduledService = pickerView(_pickerView, titleForRow: row, forComponent: component)
    }

    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
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
