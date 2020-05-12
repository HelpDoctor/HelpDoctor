//
//  EditProfileViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.05.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: EditProfilePresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let nameView = UIView()
    private let nameLabel = UILabel()
    private let contactsView = UIView()
    private let contactsLabel = UILabel()
    private let educationView = UIView()
    private let educatiobLabel = UILabel()
    private let jobView = UIView()
    private let jobLabel = UILabel()
    private let interestsView = UIView()
    private let interestsLabel = UILabel()
    private let photoView = UIView()
    private let photoLabel = UILabel()
    private let rowHeight = 50.f
    private let leading = 20.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
    }
    
    // MARK: - Setup views
    private func setupViews() {
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Редактировать профиль",
                        font: .boldSystemFontOfSize(size: 14))
        setupNameView()
        setupView(newView: contactsView, prevView: nameView)
        setupView(newView: educationView, prevView: contactsView)
        setupView(newView: jobView, prevView: educationView)
        setupView(newView: interestsView, prevView: jobView)
        setupView(newView: photoView, prevView: interestsView)
        setupLabel(label: nameLabel, onView: nameView, text: "ФИО и пол")
        setupLabel(label: educatiobLabel, onView: educationView, text: "Образование")
        setupLabel(label: contactsLabel, onView: contactsView, text: "Дата рождения, номер телефона, место жительства")
        setupLabel(label: jobLabel, onView: jobView, text: "Специализация, место работы")
        setupLabel(label: interestsLabel, onView: interestsView, text: "Научные интересы")
        setupLabel(label: photoLabel, onView: photoView, text: "Фото профиля")
    }
    
    private func setupNameView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAttachmentTap(_:)))
        nameView.addGestureRecognizer(tap)
        nameView.addViewBackedBorder(side: .bottom,
                                     thickness: 1,
                                     color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                      constant: headerHeight).isActive = true
        nameView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupView(newView: UIView, prevView: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAttachmentTap(_:)))
        newView.addGestureRecognizer(tap)
        newView.addViewBackedBorder(side: .bottom,
                                    thickness: 1,
                                    color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newView.topAnchor.constraint(equalTo: prevView.bottomAnchor).isActive = true
        newView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        newView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
    }
    
    private func setupLabel(label: UILabel, onView: UIView, text: String) {
        label.textAlignment = .left
        label.font = .boldSystemFontOfSize(size: 14)
        label.textColor = .white
        label.text = text
        label.numberOfLines = 0
        onView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: onView.leadingAnchor,
                                       constant: leading).isActive = true
        label.trailingAnchor.constraint(equalTo: educationView.trailingAnchor,
                                        constant: -leading).isActive = true
        label.centerYAnchor.constraint(equalTo: onView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: onView.heightAnchor).isActive = true
    }
    
    @objc func handleAttachmentTap(_ sender: UITapGestureRecognizer) {
        switch sender.view {
        case nameView:
            presenter?.toChangeName()
        case educationView:
            presenter?.toChangeEducation()
        case contactsView:
            presenter?.toChangeContacts()
        case jobView:
            presenter?.toChangeJob()
        case interestsView:
            presenter?.toChangeInterest()
        case photoView:
            presenter?.toChangePhoto()
        default:
            print("Error")
        }
    }
    
}
