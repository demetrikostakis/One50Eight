//
//  Update_Client_Profile.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class Input_Client_Profile: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    
    var clientRecord:CKRecord!

    @IBOutlet weak var yardSizePicker: UIPickerView!
    @IBOutlet weak var drivewaySizePicker: UIPickerView!
    @IBOutlet weak var distancePicker: UIPickerView!
    
    @IBOutlet weak var yardSizeLabel: UILabel!
    @IBOutlet weak var drivewaySizeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var walkwaysPicker: UISegmentedControl!
    @IBOutlet weak var deckPicker: UISegmentedControl!
    @IBOutlet weak var vehiclesPicker: UISegmentedControl!
    
    var yardSizes = ["0.1","0.5","1","1.5","2","2.5","3+"]
    var drivewaySizes = ["10 x 10","20 x 10","20 x 20","30 x 20","30 x 30","+30 x +30"]
    var distances = ["1","2","3","4","5","10","20"]
   
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let _signUp = UIBarButtonItem(title: "Sign Up", style: .Plain, target: self, action: "signUp")
        
        self.navigationItem.rightBarButtonItem = _signUp
        
        yardSizeLabel.text = "0.1 Acres"
        drivewaySizeLabel.text = "10 x 10 Sq Ft"
        distanceLabel.text = "1 Mile"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signUp(){
        
        clientRecord?.setObject(yardSizeLabel.text, forKey: "yardSize")
        clientRecord?.setObject(drivewaySizeLabel.text, forKey: "drivewaySize")
        clientRecord?.setObject(Int(distanceLabel.text!), forKey: "maxRadius")
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let publicDB = appDel.publicDB
        publicDB.saveRecord(clientRecord, completionHandler: { record,error in
            if error != nil{
                
            }else{
                dispatch_sync(dispatch_get_main_queue(), {
                    appDel.clientRecord = record
                    self.performSegueWithIdentifier("signUpClient", sender: self)
                })
            }
        })
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
            return 1
        case 1:
            return 1
        case 2:
            return 2
        default:
            return 4
        }
    }
    
    //
    //pickerview implimentation
    //
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == drivewaySizePicker{
            drivewaySizeLabel.text = drivewaySizes[row] + " Sq Ft"
            return
        }else if pickerView == distancePicker{
            distanceLabel.text = distances[row] + " Miles"
            if(row == 0){
                distanceLabel.text = distances[row] + " Mile"
            }
            return
        }
        else{
            yardSizeLabel.text = yardSizes[row] + " Acres"
            if(row == 2){
                yardSizeLabel.text = yardSizes[row] + " Acre"
            }
            return
        }
        

    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == drivewaySizePicker{
            return drivewaySizes[row]
        }else if pickerView == distancePicker{
            return distances[row]
        }
        return yardSizes[row]
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == drivewaySizePicker{
            return drivewaySizes.count
        }else if pickerView == distancePicker{
            return distances.count
        }
        return yardSizes.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }


}
