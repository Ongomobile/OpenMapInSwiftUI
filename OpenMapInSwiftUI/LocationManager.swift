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
    
    @Published var locationString = "1140"
    @Published var isValid: Bool = true
    static let instance = LocationManager()
    
    func openMapWithAddress (address: String) {
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                DispatchQueue.main.async { self.isValid = false }
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
            mapItem.name = address
            mapItem.openInMaps(launchOptions: nil)
        }
        
    }
}


