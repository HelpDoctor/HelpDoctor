//
//  UpdateProfile.swift
//  HelpDoctor
//
//  Created by Anton Fomkin on 31.10.2019.
//  Copyright © 2019 Anton Fomkin. All rights reserved.
//

import Foundation

class UpdateProfileKeyUser {
    var first_name: String?
    var last_name: String?
    var middle_name: String?
    var phone_number: String?
    var birthday: String?
    var city_id: Int?
    var foto: String?
    var gender: String?
    var is_medic_worker: Int?
    var jsonModel: [String: Any] = [:]
    var jsonData: Data?
    var responce: (Int?, String?)?
    
    init (first_name: String?,
          last_name: String?,
          middle_name: String?,
          phone_number: String?,
          birthday: String?,
          city_id: Int?,
          foto: String?,
          gender: String?,
          is_medic_worker: Int?) {
        
        self.first_name = first_name
        self.last_name = last_name
        self.middle_name = middle_name
        self.phone_number = phone_number
        self.birthday = birthday
        self.city_id = city_id
        self.foto = foto
        self.gender = gender
        self.is_medic_worker = is_medic_worker
        
        jsonModel = [:]
        jsonData = nil
        let dataUser: [String: Any] = ["first_name": first_name as Any,
                                        "last_name": last_name as Any,
                                        "middle_name": middle_name as Any,
                                        "phone_number": phone_number as Any,
                                        "birthday": birthday as Any,
                                        "city_id": city_id as Any,
                                        "foto": foto as Any,
                                        "gender": gender as Any,
                                        "is_medic_worker": is_medic_worker as Any
                                       ]
        self.jsonModel = ["user": dataUser]
        self.jsonData = todoJSON(obj: jsonModel)
    }
}
