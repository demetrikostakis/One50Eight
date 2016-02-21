//
//  NewRequestPage.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class NewRequestPage: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startButton.layer.cornerRadius = self.startButton.frame.size.width/2
        self.startButton.clipsToBounds = true
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
