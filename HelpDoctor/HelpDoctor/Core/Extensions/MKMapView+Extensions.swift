//
//  MKMapView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit

typealias MKMapBounds = (northEast: CLLocationCoordinate2D, southWest: CLLocationCoordinate2D)

extension MKMapView {
    
    var mapBounds: MKMapBounds {
        let northEastPoint = CGPoint(x: bounds.origin.x + bounds.size.width, y: bounds.origin.y)
        let southWestPoint = CGPoint(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height)
        return (convert(northEastPoint, toCoordinateFrom: self), convert(southWestPoint, toCoordinateFrom: self))
    }
    
    var mapBoundsDistance: CLLocationDistance {
        let mapBounds = self.mapBounds
        let northEastLocation = CLLocation(latitude: mapBounds.northEast.latitude,
                                           longitude: mapBounds.northEast.longitude)
        let southWestLocation = CLLocation(latitude: mapBounds.southWest.latitude,
                                           longitude: mapBounds.southWest.longitude)
        return northEastLocation.distance(from: southWestLocation)
    }
    
}
