// Randy Blakeslee
// CS3200 Final Project

//
//  NewRouteVC.swift
//  RunBoyRun
//
//  Created by Student User on 4/21/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GLKit



class NewRouteVC : UIViewController {
    
    var testlocation = CLLocationCoordinate2DMake(41.7452, -111.8097)
    let pinAnnotation = CustomMapPinAnnotation()
    
    var tapRecognizer : TapGestureRecognizer!
    
    var routePoints = [CustomMapPinAnnotation]()
    var routeLat = [Float]()
    var routeLon = [Float]()
    
    var defaultStrideLength = 2.17
    var walking = 3.5
    var jogging = 5.0
    var running = 7.5
    var totalDistance = Float(0.0)
    var estimatedTime = 0.0
    var numOfRoutes = 0
    
    let newRoute = Route(number: 0, distance: 0.0, time: 0.0)
    
    
    @IBOutlet weak var addMapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    // When the add point button is pressed add a point to the map when tapped
    @IBAction func addPointButton(sender: AnyObject) {
        
        pinAnnotation.setCoordinate(testlocation)
        
        addMapView.addAnnotation(pinAnnotation)
        
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }
    
    // When the delete point button is pressed delete all the pins from the map
    @IBAction func deletePointButton(sender: AnyObject) {
        addMapView.removeAnnotation(pinAnnotation)
        
        for item in routePoints {
            addMapView.removeAnnotation(item)
        }
        routePoints.removeAll()
        totalDistance = 0
        routeLat.removeAll()
        routeLon.removeAll()
        distanceLabel.text = "Total Distance: \(totalDistance) ft"
    }
    
    // Save the current route and put it in the tableview on the Routes view
    @IBAction func saveRouteButton(sender: AnyObject) {
        newRoute.routeNumber = numOfRoutes
        newRoute.routeDistance = totalDistance
        newRoute.routeTime = estimatedTime
        numOfRoutes = numOfRoutes + 1
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            addMapView.userTrackingMode = .FollowWithHeading
        }
        
        
        
        
        
        tapRecognizer = TapGestureRecognizer(target: self, action: "tapped:")
        addMapView.addGestureRecognizer(tapRecognizer)
        
    }
    
    // What happens when the map is tapped
    func tapped(c: TapGestureRecognizer) {
        if c.state == .Ended {
            let location = c.locationInView(addMapView)
            let coordinates = addMapView.convertPoint(location, toCoordinateFromView: addMapView)
            print("Lat: \(coordinates.latitude) Long: \(coordinates.longitude)")
            
            let routeAnnotation = CustomMapPinAnnotation()
            routeAnnotation.setCoordinate(coordinates)
            addMapView.addAnnotation(routeAnnotation)
            routePoints.append(routeAnnotation)
            routeLat.append(Float(coordinates.latitude))
            routeLon.append(Float(coordinates.longitude))
            
            if routePoints.count >= 2 {
                let R = Float(6371000)
                let lat1Rad = GLKMathDegreesToRadians(routeLat.last!)
                let lat2Rad = GLKMathDegreesToRadians(routeLat[routeLat.count - 2])
                let latDiff = GLKMathDegreesToRadians(routeLat[routeLat.count - 2] - routeLat.last!)
                let lonDiff = GLKMathDegreesToRadians(routeLon[routeLon.count - 2] - routeLon.last!)
                
                let a = sin(latDiff/2) * sin(latDiff/2) + cos(lat1Rad) * cos(lat2Rad) * sin(lonDiff/2) * sin(lonDiff/2)
                let c = 2 * atan2(sqrt(a),sqrt(1-a))
                
                var d = R * c
                
                d = d * 0.62137
                
                totalDistance = totalDistance + d
                
                distanceLabel.text = "Total Distance: \(totalDistance) ft"
            }
        }
    }
    
    
    
}

extension NewRouteVC: UIGestureRecognizerDelegate {
    func handleLongPress(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Ended
        {
            let touchLocation = sender.locationInView(addMapView)
            let touchCoord = addMapView.convertPoint(touchLocation, toCoordinateFromView: addMapView)
            print("Lat: \(touchCoord.latitude) Long: \(touchCoord.longitude)")
            return
        }
    }
    
    

}

// Allows custom annotations for the mapview
extension NewRouteVC: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is CustomMapPinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinTintColor = UIColor.blueColor()
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            let deleteButton = UIButton()
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            deleteButton.backgroundColor = UIColor.redColor()
            
            pinAnnotationView.leftCalloutAccessoryView = deleteButton
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? CustomMapPinAnnotation {
            mapView.removeAnnotation(annotation)
        }
    }
    
    

}

// Allows the mapview to work and tracks current location
extension NewRouteVC: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            addMapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let firstLocation = locations.first {
            let coords = firstLocation.coordinate
            print("\(coords.latitude), \(coords.longitude)")
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("failed to get location")    }
}


    

