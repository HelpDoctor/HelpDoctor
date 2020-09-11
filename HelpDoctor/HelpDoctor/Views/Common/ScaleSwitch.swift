//
//  ScaleSwitch.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ScaleSwitch: UISwitch {

    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(scaleX: 34 / 51, y: 20 / 31)
    }

}
