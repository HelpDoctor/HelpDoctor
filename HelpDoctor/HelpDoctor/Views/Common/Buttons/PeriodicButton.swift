//
//  PeriodicButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class PeriodicButton: UIButton {
    
    var enabledBackgroundColor: UIColor {
        return .clear
    }
    
    var disabledBackgroundColor: UIColor {
        return .hdButtonDisabledColor
    }
    
    var selectedBackgroundColor: UIColor {
        return .hdButtonColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update(isEnabled: self.isEnabled)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update(isEnabled: self.isEnabled)
    }
    
    convenience init(title: String? = nil) {
        self.init()
        
        if let title = title {
            setTitle(title, for: .normal)
            titleLabel?.font = UIFont.systemFontOfSize(size: 12)
        }
        
        setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), for: .normal)
        setTitleColor(.white, for: .selected)
        layer.borderWidth = 1
        layer.cornerRadius = 15
        clipsToBounds = true
        update(isEnabled: self.isEnabled)
    }
    
    func update(isEnabled: Bool) {
        self.isEnabled = isEnabled
        self.backgroundColor = isEnabled
            ? enabledBackgroundColor
            : disabledBackgroundColor
    }
    
    func update(isSelected: Bool) {
        self.isSelected = isSelected
        self.backgroundColor = isSelected
            ? selectedBackgroundColor
            : enabledBackgroundColor
        self.layer.borderColor = isSelected
            ? selectedBackgroundColor.cgColor
            : UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
    }
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    
}
