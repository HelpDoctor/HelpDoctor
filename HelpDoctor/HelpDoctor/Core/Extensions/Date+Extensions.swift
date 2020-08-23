//
//  Date+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

extension Date {

    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.calendar = Calendar.autoupdatingCurrent
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
    
}
