//
//  SetDateCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/21/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class SetDateCell: UITableViewCell {
    
    var startCell: Bool = false
    
    var dateString: String?
    var date: NSDate?
    
    let dateFormatter = NSDateFormatter()
    
    var parentViewController: SetRequestDate!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    @IBAction func updateDateAndTime(sender: UIDatePicker){
        
        date = datePicker.date
        
        dateFormatter.dateFormat = "dd MMMM  hh:mm a"
        
        dateString = dateFormatter.stringFromDate(self.date!)
        
        if(startCell == true){
            parentViewController.startTime = date
            parentViewController.startTimeString = dateString
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            parentViewController.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
        if parentViewController.startTime != nil{
            parentViewController.nextButton.enabled = true
        }
        
    }
    
}
