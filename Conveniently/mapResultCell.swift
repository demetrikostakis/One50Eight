//
//  mapResultCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/8/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class mapResultCell: UITableViewCell {

    @IBOutlet weak var clientProfilePicture: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var yardSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
