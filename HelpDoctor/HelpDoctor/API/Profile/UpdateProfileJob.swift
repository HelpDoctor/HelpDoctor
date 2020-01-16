//
//  UpdateProfileJob.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 31.10.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

class UpdateProfileKeyJob {
    var arrayJob: [[String: Any]] = []
    var jsonData: Data?
    var responce: (Int?, String?)?
    
    init (arrayJob: [[String: Any]]) {
        
        self.arrayJob = arrayJob
        jsonData = nil
        
        let jsonModel = ["job": self.arrayJob]
        self.jsonData = todoJSON_Array(obj: jsonModel)
    }
}
