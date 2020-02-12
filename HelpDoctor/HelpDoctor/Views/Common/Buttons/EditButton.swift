//
//  EditButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EditButton: UIButton {
    
    var enabledBackgroundColor: UIColor {
        return .clear
    }
    
    var disabledBackgroundColor: UIColor {
        return .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let icon = UIImage(named: "Edit_Button.pdf")
        setImage(icon, for: .normal)
        updateLayerProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerProperties() {
        clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
}
