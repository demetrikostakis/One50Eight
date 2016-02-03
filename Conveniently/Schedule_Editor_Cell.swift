//
//  Schedule_Editor_Cell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/2/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class Schedule_Editor_Cell: UITableViewCell, MultiSelectSegmentedControlDelegate {

    @IBOutlet weak var daySelector: MultiSelectSegmentedControl!
    
    var tableViewController: Input_Provider_Profile!
    var tableView: UITableView!
    var array = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView = self.superview as? UITableView
        daySelector.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func multiSelect(multiSelecSegmendedControl: MultiSelectSegmentedControl!, didChangeValue value: Bool, atIndex index: UInt) {
        if(value == true){
            
            /*
            tableView.beginUpdates()
            array = multiSelecSegmendedControl.selectedSegmentTitles
            let indexPaths = [NSIndexPath(forRow: array.count-1, inSection: 1)]
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)

            */
            tableViewController.numberOfDaysSelected = multiSelecSegmendedControl.selectedSegmentTitles as! [String]
            self.tableView.reloadData()
            print(multiSelecSegmendedControl.selectedSegmentTitles)
            
        }else{
            tableViewController.numberOfDaysSelected = multiSelecSegmendedControl.selectedSegmentTitles as! [String]
            self.tableView.reloadData()
        }
    }

}
