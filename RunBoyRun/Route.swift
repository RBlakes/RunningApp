//
//  Route.swift
//  RunBoyRun
//
//  Created by Student User on 4/25/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import Foundation
import UIKit

class Route : NSObject {
    
    var routeNumber : Int
    var routeDistance : Float
    var routeTime : Double
    
    init(number: Int, distance: Float, time: Double) {
        self.routeNumber = number
        self.routeDistance = distance
        self.routeTime = time
    }
    
}
