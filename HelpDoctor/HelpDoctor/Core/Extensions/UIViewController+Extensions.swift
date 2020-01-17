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
    
    func setupHeaderView() {
        let headerView = HeaderView(title: "HelpDoctor")
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: 60)
        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    func setupClearHeaderView() {
        let headerView = HeaderView(title: "HelpDoctor", withAvatar: true)
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: 60)
        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    func setupHeaderViewWithAvatar(title: String,
                                   text: String?,
                                   userImage: String?,
                                   presenter: Presenter?) {
        let headerView = HeaderViewWithoutLogo(title: title,
                                               text: text,
                                               userImage: userImage,
                                               presenter: presenter)
        view.addSubview(headerView)
        let width = UIScreen.main.bounds.width
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func showAlert(message: String?) {
        view.viewWithTag(999)?.removeFromSuperview()
        let alert = AlertView(message: message ?? "Ошибка")
        alert.tag = 999
        view.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
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
        savedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        savedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        savedView.widthAnchor.constraint(equalToConstant: 123).isActive = true
        savedView.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    func redStar(text: String) -> NSMutableAttributedString {
        let text = text
        let range = (text as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        return attributedString
    }
    
    func addBlurEffect() {
        let activityView = UIView()
        activityView.frame = view.bounds
        activityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityView.tag = 997
        view.addSubview(activityView)
    }
    
    func removeBlurEffect() {
        view.viewWithTag(997)?.removeFromSuperview()
    }
    
}
