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
    
    var clientRecord: CKRecord?
    
    var providerRecords: [CKRecord] = []
    
    let locationManager = CLLocationManager()
    
    var currentLocation:CLLocation?
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var viewWithButtons: UIView!
    
    var selectedProvider: CKRecord?
    var tappedProvider: CKRecord?
    
    func nextPage(){
        performSegueWithIdentifier("setRequestDate", sender: self)
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
    
    var nextButton: UIBarButtonItem!
    
    
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
        return providerRecords.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! providerCell
        
        let firstName = self.providerRecords[indexPath.row].objectForKey("firstName") as! String
        let lastName = self.providerRecords[indexPath.row].objectForKey("lastName") as! String
        
        cell.providerName.text = "\(firstName) \(lastName)"
        cell.parentViewController = self

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
        if segue.identifier == "showProviderProfile"{
            
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
