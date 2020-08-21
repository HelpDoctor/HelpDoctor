//
//  HDButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class HDButton: UIButton {
    
    let shapeLayer = CAShapeLayer()
    
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
        //        self.backgroundColor = isSelected
        //            ? selectedBackgroundColor
        //            : enabledBackgroundColor
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if self.isSelected {
            clipsToBounds = true
            let path = UIBezierPath(roundedRect: CGRect(x: -10,
                                                        y: -self.frame.height / 2,
                                                        width: self.frame.width + 20,
                                                        height: self.frame.height * 2),
                                    cornerRadius: 0)
            let buttonPath = UIBezierPath(roundedRect: CGRect(x: -1,
                                                              y: -1,
                                                              width: self.frame.width + 2,
                                                              height: self.frame.height + 2),
                                          cornerRadius: self.frame.height / 2)
            path.append(buttonPath.reversing())
            shapeLayer.path = path.cgPath
            self.layer.addSublayer(shapeLayer)
            shapeLayer.shadowOpacity = 1
            shapeLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            shapeLayer.shadowOffset = CGSize(width: 0, height: 4)
            shapeLayer.shadowRadius = 4
        } else {
            shapeLayer.removeFromSuperlayer()
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 4.0
            self.layer.masksToBounds = false
        }
    }
    
}
