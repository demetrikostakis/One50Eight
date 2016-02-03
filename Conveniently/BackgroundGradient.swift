//
//  BackgroundGradient.swift
//  Conveniently
//
//  Created by Demetri Kostakis on 2/1/16.
//  Copyright © 2016 One50Eight. All rights reserved.
//

import UIKit
import QuartzCore

class BackgroundGradient: NSObject {
    
    
    var greyGradient: CAGradientLayer!
    var blueGradient: CAGradientLayer!
    
    func gGradient() ->CAGradientLayer{
        
        let colorOne: UIColor = UIColor(colorLiteralRed: 20, green: 20, blue: 20, alpha: 1.0)
        
        let colorTwo: UIColor = UIColor(hue: 0.625, saturation: 0.0, brightness: 0.85, alpha: 1.0)
        
        let colorThree: UIColor = UIColor(hue: 0.625, saturation: 0.0, brightness: 0.7, alpha: 1.0)
        
        let colorFour: UIColor = UIColor(hue: 0.625, saturation: 0.0, brightness: 0.4, alpha: 1.0)
        
        
        let colors = [colorOne, colorTwo, colorThree, colorFour]
        
        
        let stopOne = NSNumber(float: 0.0)
        
        let stopTwo = NSNumber(float: 0.2)
        
        let stopThree = NSNumber(float: 0.99)
        
        let stopFour = NSNumber(float: 1.0)
        
        let locations = [stopOne, stopTwo, stopThree, stopFour]
        
        greyGradient.colors = colors
        greyGradient.locations = locations
        
        return greyGradient
        
    }
    
}
