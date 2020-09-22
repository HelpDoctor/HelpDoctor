//
//  UserStatus.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 07.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import Foundation

final class VerificationResponse {
    var verification: [Verification]? = []
    var responce: (Int?, String?)?
}

struct Verification {
    var status: String?
    var message: String?
    
    init(_ dictionary: [String: Any]) {
        self.status = dictionary["status"] as? String
        self.message = dictionary["message"] as? String
    }

}

func parseJSON_getVerification(for startPoint: [String: Any]?,
                               response: URLResponse?) -> ([Verification], Int?, String?)? {
    
    var verification: Verification
    
    guard let httpResponse = response as? HTTPURLResponse else { return ([], nil, nil) }
    guard let startPoint = startPoint else { return ([], nil, nil) }
    
    verification = Verification(startPoint)
    
    return ([verification], httpResponse.statusCode, nil)
}
*/
