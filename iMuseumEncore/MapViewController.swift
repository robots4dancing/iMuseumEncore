//
//  MapViewController.swift
//  iMuseumEncore
//
//  Created by Valerie Greer on 3/14/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var masterMuseumArray = [Museum]()

    @IBOutlet var museumMapView         :MKMapView!
    
    func points() {
        for museum in masterMuseumArray {
            print("\(museum.museumLon),\(museum.museumLat)")
        }
    }
    
    func annotateMapLocations() {
        var pinsToRemove = [MKPointAnnotation]()
        for annotation in museumMapView.annotations {
            if annotation is MKPointAnnotation {
                pinsToRemove.append(annotation as! MKPointAnnotation)
            }
        }
        museumMapView.removeAnnotations(pinsToRemove)
        
        for museum in self.masterMuseumArray {
            let museumAnnotation = MKPointAnnotation()
            print("\(museum.museumName)")
            print("\(museum.museumLat), \(museum.museumLon)")
            museumAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(museum.museumLat), longitude: CLLocationDegrees(museum.museumLon))
            museumAnnotation.title = museum.museumName
            museumAnnotation.subtitle = museum.museumFullAddress
            museumMapView.addAnnotation(museumAnnotation)
        }
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        if masterMuseumArray != appDelegate.masterMuseumArray {
            masterMuseumArray = appDelegate.masterMuseumArray
            annotateMapLocations()
        }
    }

    
}
