//
//  providerMapResultTableView.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/8/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit
import MapKit
import CoreLocation

class providerMapResultTableView: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var providerMap: MKMapView!
    
    var requestRecord: CKRecord = CKRecord(recordType: "Request")
    var clientRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!
    var providerRecords: [CKRecord] = []
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var viewWithButtons: UIView!
    
    var selectedProvider: CKRecord?
    var tappedProvider: CKRecord?
    var nextButton: UIBarButtonItem!
    
    var providerSelected: Bool = false
    
    
    // MARK: View Functions
    
    override func viewDidAppear(animated: Bool) {
        self.tappedProvider = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: Selector("nextPage"))
        
        nextButton.enabled = false
        self.navigationItem.rightBarButtonItem = nextButton
        
        
        
        let appdel = UIApplication.sharedApplication().delegate as! AppDelegate
        let publicDB = appdel.publicDB
        
        //let radius = 5
        
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location!, radius)
        let predicate = NSPredicate(value: true)
        
        let query: CKQuery = CKQuery(recordType: "Provider", predicate: predicate)
        
        
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {records,error in
            if error != nil{
                
            }else{
                self.providerRecords = records!
                for record in records!{
                    let providerPoint = MKPointAnnotation()
                    let location: CLLocation = record.objectForKey("address") as! CLLocation
                    let coordinate = location.coordinate
                    providerPoint.coordinate = coordinate
                    providerPoint.title = record.objectForKey("firstName") as? String
                    self.providerMap.addAnnotation(providerPoint)
                    
                }
                dispatch_sync(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Updating and Segue Functions
    func nextPage(){
        performSegueWithIdentifier("finalizeRequest", sender: self)
    }
    
    func updateSelectedItem(){
        var row = 0
        while row<self.providerRecords.count{
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: row, inSection: 0)) as! providerCell
            
            if cell._isSelected{
                selectedProvider = providerRecords[row]
                return
            }
            row++
        }
    }
    
    func updateTappedProvider(){
        var row = 0
        while row < self.providerRecords.count{
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: row, inSection: 0)) as! providerCell
            if cell._wasSelected{
                tappedProvider = providerRecords[row]
                
                let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                appDel.providerRecord = self.tappedProvider!
                
                performSegueWithIdentifier("showProviderProfile", sender: self)
                cell._wasSelected = false
                return
            }
            row++
        }
    }
    
    


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return providerRecords.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! providerCell
        
        let firstName = self.providerRecords[indexPath.row].objectForKey("firstName") as! String
        let lastName = self.providerRecords[indexPath.row].objectForKey("lastName") as! String
        
        cell.providerName.text = "\(firstName) \(lastName)"
        cell.parentViewController = self
        
        let services = self.providerRecords[indexPath.row].objectForKey("services") as! [String]
        
        for service in services{
            switch service{
                case "Mowing Lawn":
                    cell.lawnImage.image = UIImage(imageLiteral: "grass_filled_100px.png")
                case "Snow":
                    cell.snowImage.image = UIImage(imageLiteral: "winter_filled_100px.png")
                case "Raking Leaves":
                cell.leaveImage.image = UIImage(imageLiteral: "autumn_filled_100px.png")
                default:
                    break
            }
        }
        
        let clientLocation = self.clientRecord.objectForKey("address") as! CLLocation
        let providerLocation = providerRecords[indexPath.row].objectForKey("address") as! CLLocation
        let distanceFromProvider: Double = Double(clientLocation.distanceFromLocation(providerLocation) * 0.000621371)

        cell.distance.text = "\(Double(round(distanceFromProvider*10)/10)) Miles"

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! providerCell
        cell.checkTapped(cell.checkButton)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finalizeRequest"{
            let requestPage = segue.destinationViewController as! Request
            requestPage.clientRecord = self.clientRecord
            requestPage.providerRecord = self.selectedProvider
            requestPage.requestRecord = self.requestRecord
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        for _location in locations{
            self.currentLocation = _location
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }

}
