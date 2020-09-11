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
    private let titleView = UIView()
    private let dividerView = UIView()
    private let nameView = UIView()
    private let contactsView = UIView()
    private let educationView = UIView()
    private let jobView = UIView()
    private let interestsView = UIView()
    private let photoView = UIView()
    private let rowHeight = 50.f
    private let leading = 10.f
    
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
                        title: "Редактирование профиля",
                        font: .boldSystemFontOfSize(size: 14))
        setupTitleView()
        setupDividerView()
        setupNameView()
        setupView(newView: contactsView, prevView: nameView)
        setupView(newView: educationView, prevView: contactsView)
        setupView(newView: jobView, prevView: educationView)
        setupView(newView: interestsView, prevView: jobView)
        setupView(newView: photoView, prevView: interestsView)
        setupIcon(onView: nameView, iconName: "User_Icon")
        setupIcon(onView: contactsView, iconName: "Personal_Info_Icon")
        setupIcon(onView: educationView, iconName: "Education_Icon")
        setupIcon(onView: jobView, iconName: "Job_Icon")
        setupIcon(onView: interestsView, iconName: "Interest_Icon")
        setupIcon(onView: photoView, iconName: "Camera_Icon")
        setupLabel(onView: nameView, text: "ФИО и пол")
        setupLabel(onView: educationView, text: "Образование")
        setupLabel(onView: contactsView, text: "Дата рождения, номер телефона, место жительства")
        setupLabel(onView: jobView, text: "Специализация, место работы")
        setupLabel(onView: interestsView, text: "Научные интересы")
        setupLabel(onView: photoView, text: "Фото профиля")
    }
    
    private func setupTitleView() {
        let text = """
        Выберите параметр для внесения изменений в ваш профиль
        """
        let label = UILabel()
        let leading = 10.f
        
        titleView.backgroundColor = .white
        label.textAlignment = .left
        label.font = .systemFontOfSize(size: 12)
        label.textColor = .black
        label.text = text
        label.numberOfLines = 0
        view.addSubview(titleView)
        titleView.addSubview(label)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: headerHeight).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leading).isActive = true
        label.topAnchor.constraint(equalTo: titleView.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
    }
    
    private func setupDividerView() {
        dividerView.backgroundColor = .searchBarTintColor
        view.addSubview(dividerView)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dividerView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 10).isActive = true
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
        nameView.topAnchor.constraint(equalTo: dividerView.bottomAnchor).isActive = true
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
    
    private func setupIcon(onView: UIView, iconName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: iconName)
        onView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: onView.leadingAnchor,
                                           constant: leading).isActive = true
        imageView.centerYAnchor.constraint(equalTo: onView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLabel(onView: UIView, text: String) {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFontOfSize(size: 14)
        label.textColor = .white
        label.text = text
        label.numberOfLines = 0
        onView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: onView.leadingAnchor,
                                       constant: leading + 75).isActive = true
        label.trailingAnchor.constraint(equalTo: onView.trailingAnchor,
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
