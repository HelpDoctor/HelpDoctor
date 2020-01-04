//
//  UIImage+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UIImage {
    func toString() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString()
    }
}
