//
//  LocationManager.swift
//  OpenMapInSwiftUI
//
//  Created by Michael Haslam on 1/26/21.
//

import UIKit
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    lazy var geocoder = CLGeocoder()
    
    @Published var locationString = ""
    @Published var invalid: Bool = false
   
    func openMapWithAddress () {
        
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.invalid = true
                }
                print(error.localizedDescription)
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            guard let lat = placemark.location?.coordinate.latitude else{return}
            
            guard let lon = placemark.location?.coordinate.longitude else{return}
            
            let coords = CLLocationCoordinate2DMake(lat, lon)
            
            let place = MKPlacemark(coordinate: coords)
            
            let mapItem = MKMapItem(placemark: place)
            mapItem.name = self.locationString
            mapItem.openInMaps(launchOptions: nil)
        }
        
    }
}


