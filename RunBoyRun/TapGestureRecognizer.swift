// Randy Blakeslee
// CS3200 Final Project

//
//  TapGestureRecognizer.swift
//  RunBoyRun
//
//  Created by Student User on 4/25/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// Custom class for a single tap on the mapview
class TapGestureRecognizer: UIGestureRecognizer {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            state = .Failed
        }
        state = .Began
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        state = .Ended
    }
}
