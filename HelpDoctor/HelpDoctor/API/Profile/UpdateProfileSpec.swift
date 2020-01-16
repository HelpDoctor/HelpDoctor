//
//  UpdateProfileSpec.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 01.11.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

class UpdateProfileKeySpec {
    var arraySpec: [[String: Any]] = []
    var jsonData: Data?
    var responce: (Int?, String?)?
    
    init (arraySpec: [[String: Any]]) {
        
        self.arraySpec = arraySpec
        jsonData = nil
        
        let jsonModel = ["spec": self.arraySpec]
        self.jsonData = todoJSON_Array(obj: jsonModel)
    }
}
