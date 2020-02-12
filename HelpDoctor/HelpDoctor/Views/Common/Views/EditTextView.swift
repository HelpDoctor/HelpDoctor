//
//  EditTextView.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 04.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EditTextView: UIView {
    let textView = UITextView()
    private var editButton = EditButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupEditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        textView.font = UIFont.systemFontOfSize(size: 12)
        textView.textColor = .black
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 5
        textView.isEditable = false
        self.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupEditButton() {
        editButton = EditButton()
        editButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.addSubview(editButton)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -8).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    @objc private func buttonPressed() {
        textView.isEditable = true
    }
}
