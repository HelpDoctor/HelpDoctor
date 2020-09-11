//
//  PlusButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class PlusButton: UIButton {
    
    var enabledBackgroundColor: UIColor {
        return .clear
    }
    
    var disabledBackgroundColor: UIColor {
        return .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let icon = UIImage(named: "Plus_Button.pdf")
        setImage(icon, for: .normal)
        updateLayerProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(type: TypeCheckbox = .square) {
        self.init()
        switch type {
        case .circle:
            let icon = UIImage(named: "Plus_Button.pdf")
            setImage(icon, for: .normal)
            updateLayerProperties()
        case .square:
            let icon = UIImage(named: "PlusButtonSquare.pdf")
            setImage(icon, for: .normal)
        }
    }
    
    func updateLayerProperties() {
        layer.cornerRadius = 20
        clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
}

