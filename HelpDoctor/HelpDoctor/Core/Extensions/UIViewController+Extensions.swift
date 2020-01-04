//
//  UIViewController+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupBackground() {
        let backgroundImage = UIImageView()
        let backgroundImageName = "Background.png"
        guard let image = UIImage(named: backgroundImageName) else {
            assertionFailure("Missing ​​\(backgroundImageName) asset")
            return
        }
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        backgroundImage.image = image
        backgroundImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
        view.addSubview(backgroundImage)
    }
    
    func showAlert(message: String?) {
        view.viewWithTag(999)?.removeFromSuperview()
        let alert = AlertView(message: message ?? "Ошибка")
        alert.tag = 999
        view.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        alert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        alert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        alert.heightAnchor.constraint(equalToConstant: 57).isActive = true
    }
    
    func showSaved(message: String?) {
        view.viewWithTag(998)?.removeFromSuperview()
        let savedView = SavedView(message: message ?? "Сохранено")
        savedView.tag = 998
        view.addSubview(savedView)
        savedView.translatesAutoresizingMaskIntoConstraints = false
        savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55).isActive = true
        savedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        savedView.widthAnchor.constraint(equalToConstant: 123).isActive = true
        savedView.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
}
