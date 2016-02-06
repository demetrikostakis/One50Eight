//
//  Day_Editor_Cell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class Day_Editor_Cell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var startTime: UIPickerView!
    @IBOutlet weak var endTime: UIPickerView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    var textString: String!
  
    var startTimes = ["7:00 AM","8:00 AM","9:00 AM","10:00 AM","11:00 AM","12:00 PM","1:00 PM","2:00 PM","3:00 PM","4:00 PM","5:00 PM","6:00 PM"]
    var endTimes = ["8:00 AM","9:00 AM","10:00 AM","11:00 AM","12:00 PM","1:00 PM","2:00 PM","3:00 PM","4:00 PM","5:00 PM","6:00 PM","7:00 PM"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dayLabel.text = textString
        //self.horizontalScrollView.contentSize = CGSizeMake(horizontalScrollView.contentSize.width, horizontalScrollView.frame.height)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == startTime){
            return startTimes[row]
        }
        
        return endTimes[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == startTime){
            return startTimes.count
        }
        
        return endTimes.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}
