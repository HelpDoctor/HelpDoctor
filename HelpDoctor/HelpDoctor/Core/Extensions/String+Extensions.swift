//
//  String+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

extension String {

  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (i: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, i.lowerBound)),
                                        upper: min(length, max(0, i.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}

extension String {
    
    func getWordByDeclension(number: Int, arrayWords: [String]) -> String {
        let funcNumber = number % 100
        var resultString = ""
        if funcNumber >= 11 && funcNumber <= 19 {
            resultString = arrayWords[2]
        } else {
            let i = funcNumber % 10
            switch i {
            case 1:
                resultString = arrayWords[0]
            case 2, 3, 4:
                resultString = arrayWords[1]
            default:
                resultString = arrayWords[2]
            }
        }
        return resultString
    }
    
}
