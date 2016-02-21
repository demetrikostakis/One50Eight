//
//  providerCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/8/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class providerCell: UITableViewCell {
    
    
    

    @IBOutlet weak var providerProfilePicture: UIImageView!
    @IBOutlet weak var priceForYard: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var providerName: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var parentViewController: providerMapResultTableView!
    
    var _isSelected:Bool = false
    var _wasSelected:Bool = false
    
    @IBAction func checkTapped(button: UIButton) {
        
        if button.selected{
            
            _isSelected = false
            
            parentViewController.nextButton.enabled = false
            
            button.selected = false
        }else{
            
            _isSelected = true
            
           
            parentViewController.nextButton.enabled = true
            parentViewController.updateSelectedItem()
            
            button.selected = true
        }

        
        
        
    }
    
    @IBAction func infoTapped(button: UIButton) {
        self._wasSelected = true
        parentViewController.updateTappedProvider()
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    

    
    @IBOutlet weak var rating: RatingControl!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
