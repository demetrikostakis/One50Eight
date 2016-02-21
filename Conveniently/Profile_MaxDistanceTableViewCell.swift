//
//  Profile_MaxDistanceTableViewCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class Profile_MaxDistanceTableViewCell: UITableViewCell {

    var clientRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!
    
    @IBOutlet weak var radius: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.radius.layer.cornerRadius = self.radius.frame.size.width/2
        self.radius.clipsToBounds = true
        self.radius.titleLabel?.text = "\(clientRecord.objectForKey("maxRadius") as? Int)"
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
