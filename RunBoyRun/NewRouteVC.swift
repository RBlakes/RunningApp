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



class NewRouteVC : UIViewController {
    
    var testlocation = CLLocationCoordinate2DMake(41.7452, 111.8097)
    let pinAnnotation = CustomMapPinAnnotation()
    
    @IBOutlet weak var addMapView: MKMapView!
    @IBAction func addPointButton(sender: AnyObject) {
        
        pinAnnotation.setCoordinate(testlocation)
        
        addMapView.addAnnotation(pinAnnotation)
    }
    @IBAction func deletePointButton(sender: AnyObject) {
        addMapView.removeAnnotation(pinAnnotation)
    }
    @IBAction func saveRouteButton(sender: AnyObject) {
    }
    
    
    
    let locationManager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        
        
        let longPress = UILongPressGestureRecognizer()
        longPress.minimumPressDuration = 2.0
        longPress.delegate = self
        addMapView.addGestureRecognizer(longPress)
        
       
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

extension NewRouteVC: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is CustomMapPinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinTintColor = UIColor.purpleColor()
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


extension NewRouteVC: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            addMapView.userTrackingMode = MKUserTrackingMode.Follow
        }
    }
}


    

