//
//  ClientProfileTabController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class ClientProfileTabController: UITabBarController {
    
    var clientRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var openDrawer: UIBarButtonItem!
    
    @IBAction func showSettings(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Settings", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let editPersonal = UIAlertAction(title: "Edit Personal Info", style: UIAlertActionStyle.Default, handler: nil)
        let editPayment = UIAlertAction(title: "Edit Payment Info", style: UIAlertActionStyle.Default, handler: nil)
        let editYard = UIAlertAction(title: "Edit Property Info", style: UIAlertActionStyle.Default, handler: nil)
        let done = UIAlertAction(title: "Done", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(editPayment)
        alertController.addAction(editPersonal)
        alertController.addAction(editYard)
        alertController.addAction(done)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.openDrawer.target = self.revealViewController()
        self.openDrawer.action = Selector("revealToggle:")
        self.openDrawer.image = UIImage(imageLiteral: "menu_100px@1x")
        self.openDrawer.title = ""
        
        let itemOne = self.tabBar.items![0]
        let itemTwo = self.tabBar.items![1]
        let itemThree = self.tabBar.items![2]
        
        let imageOne = UIImage(imageLiteral: "user_male_circle_100px")
        let imageTwo = UIImage(imageLiteral: "bill_100px")
        let imageThree = UIImage(imageLiteral: "map_marker_100px")
        
        itemOne.image = imageWithImage(imageOne, newSize: CGSizeMake(30, 30))
        itemTwo.image = imageWithImage(imageTwo, newSize: CGSizeMake(30, 30))
        itemThree.image = imageWithImage(imageThree, newSize: CGSizeMake(30, 30))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //clips image to 30x30 so tab item can display correctly
    func imageWithImage(image: UIImage, newSize: CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0,0, newSize.width, newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
