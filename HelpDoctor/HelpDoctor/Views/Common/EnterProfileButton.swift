//
//  EnterProfileButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 31.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EnterProfileButton: UIButton {
    
    var enabledBackgroundColor: UIColor {
        return .clear
    }
    
    var disabledBackgroundColor: UIColor {
        return .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(icon: UIImage? = nil) {
        self.init()
        
        setImage(icon, for: .normal)
        layer.cornerRadius = 40
        clipsToBounds = true
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    
}
