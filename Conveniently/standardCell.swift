//
//  standardCell.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/6/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit

class standardCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let dismissKeyboardRecognizer: UIGestureRecognizer = UIGestureRecognizer(target: self, action: Selector("dismissKeyboard()"))
        self.addGestureRecognizer(dismissKeyboardRecognizer)
    }

    //call this function when a tap outside of keyboard is recognized
    func dismissKeyboard(){
        self.endEditing(true)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
