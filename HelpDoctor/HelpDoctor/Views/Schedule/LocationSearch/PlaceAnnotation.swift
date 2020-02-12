//
//  PlaceAnnotation.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let mapItem: MKMapItem
    let coordinate: CLLocationCoordinate2D
    let title, subtitle: String?
    
    init(_ mapItem: MKMapItem) {
        self.mapItem = mapItem
        coordinate = mapItem.placemark.coordinate
        title = mapItem.name
        subtitle = nil
    }
}
