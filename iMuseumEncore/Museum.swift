//
//  Museum.swift
//  iMuseumEncore
//
//  Created by Valerie Greer on 3/14/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class Museum: NSObject {
    
    var museumName      :String!
    var museumStreet    :String!
    var museumCity      :String!
    var museumState     :String!
    var museumZip       :String!
    var museumLon       :Double!
    var museumLat       :Double!
    
    var museumFullAddress :String! {
        return "\(museumStreet!), \(museumCity!), \(museumState!) \(museumZip!)"
    }
    
    init(museumName: String, museumStreet: String, museumCity: String, museumState: String, museumZip: String, museumLon: Double, museumLat: Double) {
        
        self.museumName = museumName
        self.museumStreet = museumStreet
        self.museumCity = museumCity
        self.museumState = museumState
        self.museumZip = museumZip
        self.museumLon = museumLon
        self.museumLat = museumLat
    }
    
}
