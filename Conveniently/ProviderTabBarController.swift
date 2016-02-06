//
//  ProviderTabBarController.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class ProviderTabBarController: UITabBarController {

    
    @IBOutlet var openDrawer: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.openDrawer.target = self.revealViewController()
        self.openDrawer.action = Selector("revealToggle:")
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
