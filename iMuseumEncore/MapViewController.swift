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
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masterMuseumArray = appDelegate.masterMuseumArray
        points()
    }

    
}
