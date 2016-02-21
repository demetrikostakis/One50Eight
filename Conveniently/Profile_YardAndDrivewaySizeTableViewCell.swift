//
//  Profile_YardAndDrivewaySizeTableViewCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import CloudKit

class Profile_YardAndDrivewaySizeTableViewCell: UITableViewCell {
    
    var clientRecord: CKRecord = (UIApplication.sharedApplication().delegate as! AppDelegate).clientRecord!
    
    @IBOutlet weak var drivewaySize: UILabel!
    @IBOutlet weak var yardSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        drivewaySize.text = clientRecord.objectForKey("drivewaySize") as? String
        yardSize.text = clientRecord.objectForKey("yardSize") as? String
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
