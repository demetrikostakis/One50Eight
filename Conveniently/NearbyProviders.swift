//
//  NearbyProviders.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/6/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import MapKit
import CloudKit
import CoreLocation

class NearbyProviders: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var providerMap: MKMapView!
    
    var clientRecord: CKRecord?
    
    var providerRecords: [CKRecord] = []
    
    let locationManager = CLLocationManager()
    
    var currentLocation:CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        /*
        let appdel = UIApplication.sharedApplication().delegate as! AppDelegate
        let publicDB = appdel.publicDB
        
        let radius = 5
        
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location!, radius)
        let predicate = NSPredicate(value: true)
        
        let query: CKQuery = CKQuery(recordType: "Provider", predicate: predicate)
        
        
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {records,error in
            if error != nil{
                
            }else{
                //self.providerRecords = records!
                for record in records!{
                    let providerPoint = MKPointAnnotation()
                    let location: CLLocation = record.objectForKey("address") as! CLLocation
                    let coordinate = location.coordinate
                    providerPoint.coordinate = coordinate
                    providerPoint.title = record.objectForKey("firstName") as? String
                    
                    self.providerMap.addAnnotation(providerPoint)
                    
                }
            }
        })
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
