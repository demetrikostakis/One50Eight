//
//  providerCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/8/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class providerCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lawnImage: UIImageView!
    @IBOutlet weak var snowImage: UIImageView!
    @IBOutlet weak var leaveImage: UIImageView!

    @IBOutlet weak var providerProfilePicture: UIImageView!
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
            parentViewController.providerSelected = false
            button.selected = false
        }else{
            
            if(parentViewController.providerSelected){
                
            }else{
                _isSelected = true
                
                parentViewController.nextButton.enabled = true
                parentViewController.providerSelected = true
                parentViewController.updateSelectedItem()
                
                button.selected = true
            }
            
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
