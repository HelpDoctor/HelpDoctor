//
//  GetContactList.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 08.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

func parseJSON_getContactList(for startPoint: [String: AnyObject]?,
                              response: URLResponse?) -> ([Contacts], Int?, String?)? {
    var contacts: [Contacts] = []
    
    guard  let httpResponse = response as? HTTPURLResponse
        else { return ([], nil, nil) }
    
    guard let startPoint = startPoint else { return ([], nil, nil) }
    guard let contactsJSON = startPoint["contacts"] as? [AnyObject] else { return ([], nil, nil) }
    
    for obj in contactsJSON {
        contacts.append(Contacts(id: obj["id"] as? Int,
                                 first_name: obj["first_name"] as? String,
                                 middle_name: obj["middle_name"] as? String,
                                 last_name: obj["last_name"] as? String,
                                 foto: obj["foto"] as? String,
                                 specialization: obj["specialization"] as? String))
    }
    
    return (contacts, httpResponse.statusCode, nil)
}

struct Contacts: Codable {
    let id: Int?
    let first_name: String?
    let middle_name: String?
    let last_name: String?
    let foto: String?
    let specialization: String?
}

final class ContactsList {
    var contacts: [Contacts]? = []
    var contacts_count: Int? = 0
    var responce: (Int?, String?)?
}
