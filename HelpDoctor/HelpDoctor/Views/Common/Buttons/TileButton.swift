//
//  TileButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 08.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class TileButton: UIView {
    private let icon = UIImageView()
    private let label = UILabel()
    
    convenience init(title: String, icon: String) {
        self.init()
        self.label.text = title
        self.icon.image = UIImage(named: icon)
        setupView()
        setupIcon()
        setupTitle()
    }
    
    private func setupView() {
        backgroundColor = .hdButtonColor
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
    
    private func setupIcon() {
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 55).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupTitle() {
        label.font = .boldSystemFontOfSize(size: 12)
        label.textColor = .white
        label.textAlignment = .center
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 90).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
}
