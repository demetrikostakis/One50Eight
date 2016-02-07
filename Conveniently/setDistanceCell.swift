//
//  setDistanceCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class setDistanceCell: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource{

    //Interface Builder outlets
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    //Max distances the user can choose from
    var distances = ["1","2","3","4","5","10","20"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        distanceLabel.text = "1 Mile"
        
        distancePicker.delegate = self
        distancePicker.dataSource = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return distances[row] + " Miles"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        distanceLabel.text = distances[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distances.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}
