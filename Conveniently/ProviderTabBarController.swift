//
//  ProviderTabBarController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class ProviderTabBarController: UITabBarController {

    
    var providerRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).providerRecord!
    
    @IBOutlet var openDrawer: UIBarButtonItem!
    
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

        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
