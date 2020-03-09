//
//  BackButton.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 07.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class BackButton: UIView {
    private let icon = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label.text = "Назад"
        self.icon.image = UIImage(named: "BackBrace")
        backgroundColor = .clear
        setupIcon()
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIcon() {
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 13).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
    
    private func setupTitle() {
        label.font = .systemFontOfSize(size: 14)
        label.textColor = .black
        label.textAlignment = .center
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 3).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 41).isActive = true
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
    
}
