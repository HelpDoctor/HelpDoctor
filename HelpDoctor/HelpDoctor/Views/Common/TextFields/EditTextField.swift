//
//  EditTextField.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum SourceEditTextField {
    case user
    case job
    case spec
    case interest
}

class EditTextField: UIView {
    let textField = UITextField()
    var editButton = EditButton()
    private var presenter: Presenter?
    private var source: SourceEditTextField?
    
    convenience init(placeholder: String, source: SourceEditTextField, presenter: Presenter?) {
        self.init()
        self.textField.placeholder = placeholder
        self.presenter = presenter
        self.source = source
        setupTextField()
        setupEditButton()
    }
    
    private func setupTextField() {
        textField.font = UIFont.systemFontOfSize(size: 12)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 8,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isEnabled = false
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupEditButton() {
        editButton = EditButton()
        editButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.addSubview(editButton)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: textField.topAnchor,
                                                constant: 8).isActive = true
        editButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor,
                                                     constant: -8).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    @objc private func buttonPressed() {
        if textField.isEnabled {
            textField.isEnabled = false
            editButton.setImage(UIImage(named: "Edit_Button.pdf"), for: .normal)
            guard let source = source else { return }
            presenter?.save(source: source)
        } else {
            textField.isEnabled = true
            if #available(iOS 13.0, *) {
                editButton.setImage(UIImage(named: "Save.pdf")?.withTintColor(.textFieldTextColor), for: .normal)
            } else {
                editButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
            }
        }
    }
}
