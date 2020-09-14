//
//  HTTPTask.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
