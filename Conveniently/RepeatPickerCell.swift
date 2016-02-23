//
//  RepeatPickerCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/20/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class RepeatPickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var numComponents: Int = 1
    var componentOne: [String] = []
    var componentTwo: [String] = []
    var parentViewController: SetRequestDate?

    @IBOutlet weak var picker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picker.delegate = self
        picker.dataSource = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if numComponents == 1{
            return componentOne[row]
        }else{
            switch component{
            case 0:
                return componentOne[row]
            default:
                return componentTwo[row]
            }

        }
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if numComponents == 1{
            return componentOne.count
        }else{
            switch component{
            case 0:
                return componentOne.count
            default:
                return componentTwo.count
            }
        }
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return numComponents
    }

}
