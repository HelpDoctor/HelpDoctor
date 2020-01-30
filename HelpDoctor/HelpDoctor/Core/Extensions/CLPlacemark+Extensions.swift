//
//  CLPlacemark+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 27.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import MapKit

extension CLPlacemark {
    
    var address: String {
        var address = ""
        if let subThoroughfare = self.subThoroughfare {
            address += subThoroughfare + " "
        }
        if let thoroughfare = self.thoroughfare {
            address += thoroughfare + ", "
        }
        if let locality = self.locality {
            address += locality + " "
        }
        if let administrativeArea = self.administrativeArea {
            address += administrativeArea
        }
        return address
    }
    
}
