//
//  ContactsSortPopoverController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 22.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol ContactsSortPopoverDelegate: class {
    func sortByName()
    func sortBySpec()
}

class ContactsSortPopoverController: UIViewController {
    
    weak var delegate: ContactsSortPopoverDelegate?
    private let sortByNameButton = ProfilePopoverButton(text: "Сортировать по имени",
                                                        image: nil)
    private let sortBySpecButton = ProfilePopoverButton(text: "Сортировать по\nспециальности",
                                                        image: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.171, green: 0.521, blue: 0.758, alpha: 1)
        setupSortByNameButton()
        setupSortBySpecButton()
    }
    
    override var preferredContentSize: CGSize {
        get {
            return super.preferredContentSize
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    private func setupSortByNameButton() {
        let editTap = UITapGestureRecognizer(target: self, action: #selector(sortByNamePressed(tap:)))
        sortByNameButton.addGestureRecognizer(editTap)
        sortByNameButton.isUserInteractionEnabled = true
        view.addSubview(sortByNameButton)
        
        sortByNameButton.translatesAutoresizingMaskIntoConstraints = false
        sortByNameButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sortByNameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sortByNameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sortByNameButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2).isActive = true
    }
    
    private func setupSortBySpecButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(sortBySpecPressed(tap:)))
        sortBySpecButton.addGestureRecognizer(tap)
        sortBySpecButton.isUserInteractionEnabled = true
        view.addSubview(sortBySpecButton)
        
        sortBySpecButton.translatesAutoresizingMaskIntoConstraints = false
        sortBySpecButton.topAnchor.constraint(equalTo: sortByNameButton.bottomAnchor).isActive = true
        sortBySpecButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sortBySpecButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sortBySpecButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2).isActive = true
    }
    
    @objc private func sortByNamePressed(tap: UITapGestureRecognizer) {
        delegate?.sortByName()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sortBySpecPressed(tap: UITapGestureRecognizer) {
        delegate?.sortBySpec()
        dismiss(animated: true, completion: nil)
    }
    
}
