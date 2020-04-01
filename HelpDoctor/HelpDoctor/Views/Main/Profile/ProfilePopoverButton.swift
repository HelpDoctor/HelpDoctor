//
//  ProfilePopoverButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfilePopoverButton: UIView {
    
    private let icon = UIImageView()
    private let label = UILabel()
    private let leading = 6.f
    private let width = 20.f
    
    convenience init(text: String, image: UIImage?) {
        self.init()
        self.label.text = text
        self.icon.image = image
        setupEditIcon()
        setupEditLabel()
    }
    
    private func setupEditIcon() {
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                          constant: leading).isActive = true
        icon.widthAnchor.constraint(equalToConstant: width).isActive = true
        icon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupEditLabel() {
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFontOfSize(size: 12)
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor,
                                          constant: leading).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -leading).isActive = true
        label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
}
