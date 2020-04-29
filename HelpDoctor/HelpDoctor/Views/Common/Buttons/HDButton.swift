//
//  HDButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class HDButton: UIButton {
    
    var enabledBackgroundColor: UIColor {
        return .hdButtonColor
    }
    
    var disabledBackgroundColor: UIColor {
        return .hdButtonDisabledColor
    }
    
    var selectedBackgroundColor: UIColor {
        return .red
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
            titleLabel?.font = UIFont.boldSystemFontOfSize(size: 16)
            setTitleColor(.white, for: .normal)
        }
        
        layer.cornerRadius = 20
        clipsToBounds = true
        updateLayerProperties()
        update(isEnabled: self.isEnabled)
    }
    
    convenience init(title: String? = nil, fontSize: CGFloat) {
        self.init()
        
        if let title = title {
            setTitle(title, for: .normal)
            titleLabel?.font = UIFont.boldSystemFontOfSize(size: fontSize)
            setTitleColor(.white, for: .normal)
        }
        
        layer.cornerRadius = 20
        clipsToBounds = true
        updateLayerProperties()
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
    }
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    
}
