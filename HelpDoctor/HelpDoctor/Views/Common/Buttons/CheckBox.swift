//
//  CheckBox.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum TypeCheckbox {
    case square
    case circle
}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "WhiteSelectedEllipse.pdf")
    let uncheckedImage = UIImage(named: "WhiteEllipse.pdf")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(checkedImage, for: .selected)
        setImage(uncheckedImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(type: TypeCheckbox = .square) {
        self.init()
        switch type {
        case .circle:
            layer.cornerRadius = 5
            layer.masksToBounds = true
            clipsToBounds = true
            setImage(checkedImage, for: .selected)
            setImage(uncheckedImage, for: .normal)
        case .square:
            setImage(UIImage(named: "Checkbox_Y.pdf"), for: .selected)
            setImage(UIImage(named: "Checkbox_N.pdf"), for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
    }
    
}
