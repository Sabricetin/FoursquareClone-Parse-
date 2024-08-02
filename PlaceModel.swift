//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Sabri Çetin on 26.06.2024.
//

import Foundation
import UIKit



class PlaceModel {
    
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init (){}
    
}
