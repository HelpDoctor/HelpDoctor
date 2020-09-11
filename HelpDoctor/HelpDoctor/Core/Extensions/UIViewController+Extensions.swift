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
        let backgroundImageName = "Background.pdf"
        guard let image = UIImage(named: backgroundImageName) else {
            assertionFailure("Missing ​​\(backgroundImageName) asset")
            return
        }
        backgroundImage.image = image
        backgroundImage.frame = CGRect(x: 0, y: 0, width: Session.width, height: Session.height)
        view.addSubview(backgroundImage)
    }
    
    func setupHeaderView(color: UIColor, height: CGFloat, presenter: Presenter?, title: String = "HelpDoctor") {
        let headerView = HeaderView(title: title,
                                    color: color,
                                    height: height,
                                    presenter: presenter)
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupHeaderView(color: UIColor, height: CGFloat, presenter: Presenter?, title: String, font: UIFont) {
        let headerView = HeaderView(title: title,
                                    color: color,
                                    height: height,
                                    presenter: presenter,
                                    font: font)
        headerView.tag = 996
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupHeaderView(height: CGFloat, presenter: Presenter?) {
        let headerView = HeaderView(height: height, presenter: presenter)
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func showAlert(message: String?) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideAlert))
        let alertView = UIView()
        let alert = AlertView(message: message ?? "Ошибка")
        view.viewWithTag(999)?.removeFromSuperview()
        alertView.tag = 999
        alertView.addGestureRecognizer(tap)
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        alertView.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10).isActive = true
        alert.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10).isActive = true
        alert.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
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
        savedView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        savedView.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    func showInfo(message: String?, buttonTitle: String?, iconName: String?) {
        let infoView = InfoView(message: message ?? "Ошибка",
                                buttonTitle: buttonTitle ?? "Закрыть",
                                iconName: iconName ?? "Problem.pdf")
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
    func startActivityIndicator() {
        let activityIndicator = ActivityIndicatorView(frame: CGRect(x: (Session.width - 70) / 2,
                                                                    y: (Session.height - 70) / 2,
                                                                    width: 70,
                                                                    height: 70))
        addBlurEffect()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        view.subviews.compactMap { $0 as? ActivityIndicatorView }.forEach { $0.removeFromSuperview() }
        removeBlurEffect()
    }
    
    @objc func hideAlert() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    func setupDefaultLeftView() -> UIView {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 8,
                                        height: Session.heightTextField))
        return view
    }
    
}
