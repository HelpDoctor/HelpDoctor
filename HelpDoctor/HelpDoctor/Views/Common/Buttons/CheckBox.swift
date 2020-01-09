//
//  CheckBox.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "WhiteSelectedEllipse.pdf")
    let uncheckedImage = UIImage(named: "WhiteEllipse.pdf")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        clipsToBounds = true
        setImage(checkedImage, for: .selected)
        setImage(uncheckedImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
