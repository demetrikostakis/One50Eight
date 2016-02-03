//
//  Terms_And_Conditions_Page.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class Terms_And_Conditions_Page: UIViewController, UIAlertViewDelegate{

    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBAction func dismissPage(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var alert: UIAlertController?
    var alertAction: UIAlertAction?
    
    @IBAction func displayMessage(sender: AnyObject) {
        
        alert = UIAlertController(title: "Are You Sure?", message: "Without Accepting the Terms and Conditions You Cannot Join Our Team.", preferredStyle: .Alert)
        alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alert!.addAction(alertAction!)
        self.presentViewController(alert!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
