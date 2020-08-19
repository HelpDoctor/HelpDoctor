//
//  Feedback.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 16.05.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

final class Feedback {
    
    var text: String?
    var requestParams: [String: String]
    var responce: (Int?, String?)?
    
    init(text: String?) {
        self.text = text
        requestParams = [:]
        requestParams["feedback"] = self.text
    }
    
}
