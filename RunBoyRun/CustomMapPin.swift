//
//  CustomMapPin.swift
//  RunBoyRun
//
//  Created by Student User on 4/23/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class CustomMapPinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String?
    var subtitle: String?
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
    
    
    
}
