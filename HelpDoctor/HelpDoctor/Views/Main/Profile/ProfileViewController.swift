//
//  ProfileViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private var headerView = ProfileHeaderView()
    var nameTextField = EditTextField()
    let userPhoto = UIImageView()
    private let birthDateLabel = UILabel()
    var birthDateTextField = EditTextField()
    private let contactsLabel = UILabel()
    var emailTextField = EditTextField()
    var phoneTextField = EditTextField()
    private let specLabel = UILabel()
    private var specTextField = EditTextField()
    private let locationLabel = UILabel()
    var locationTextField = EditTextField()
    private let workPlaceLabel = UILabel()
    private var workPlace1TextField = EditTextField()
    private var workPlace2TextField = EditTextField()
    private var addWorkPlaceButton = PlusButton()
    private let interestsLabel = UILabel()
    var interestsTextView = EditTextView()
    private lazy var imagePicker = ImagePicker()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getUser()
        imagePicker.delegate = self
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupNameTextField()
        setupUserPhotoView()
        setupBirthDateLabel()
        setupBirthDateTextField()
        setupContactsLabel()
        setupEmailTextField()
        setupPhoneTextField()
        setupSpecLabel()
        setupSpecTextField()
        setupLocationLabel()
        setupLocationTextField()
        setupWorkPlaceLabel()
        setupWorkPlace1TextField()
        setupWorkPlace2TextField()
        setupAddWorkPlaceButton()
        setupInterestsLabel()
        setupInterestsTextView()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupHeaderView() {
        headerView = ProfileHeaderView(title: "Мой профиль",
                                       text: nil,
                                       userImage: nil,
                                       presenter: presenter)
        scrollView.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupNameTextField() {
        nameTextField = EditTextField(placeholder: "Фамилия Имя Отчество",
                                      source: .user,
                                      presenter: presenter)
        scrollView.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupUserPhotoView() {
        let defaultImage = "Avatar.pdf"
        guard let image = UIImage(named: defaultImage) else {
            assertionFailure("Missing ​​\(defaultImage) asset")
            return
        }
        let imageSize: CGFloat = 110
        userPhoto.image = image
        scrollView.addSubview(userPhoto)
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                        constant: 10).isActive = true
        userPhoto.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        userPhoto.layer.cornerRadius = imageSize / 2
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.masksToBounds = true
        
        let button = UIButton()
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        scrollView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                        constant: 10).isActive = true
        button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        button.layer.cornerRadius = imageSize / 2
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
    }
    
    private func setupBirthDateLabel() {
        birthDateLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        birthDateLabel.textColor = .black
        birthDateLabel.text = "Дата рождения"
        birthDateLabel.textAlignment = .left
        scrollView.addSubview(birthDateLabel)
        
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDateLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5).isActive = true
        birthDateLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        birthDateLabel.widthAnchor.constraint(equalToConstant: width - 190).isActive = true
        birthDateLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupBirthDateTextField() {
        birthDateTextField = EditTextField(placeholder: "ДД.ММ.ГГГГ",
                                           source: .user,
                                           presenter: presenter)
        scrollView.addSubview(birthDateTextField)
        
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        birthDateTextField.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 3).isActive = true
        birthDateTextField.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        birthDateTextField.widthAnchor.constraint(equalToConstant: width - 190).isActive = true
        birthDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupContactsLabel() {
        contactsLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        contactsLabel.textColor = .black
        contactsLabel.text = "Контакты"
        contactsLabel.textAlignment = .left
        scrollView.addSubview(contactsLabel)
        
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 5).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        contactsLabel.widthAnchor.constraint(equalToConstant: width - 190).isActive = true
        contactsLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupEmailTextField() {
        emailTextField = EditTextField(placeholder: "e-mail",
                                       source: .user,
                                       presenter: presenter)
        emailTextField.editButton.isEnabled = false
        emailTextField.editButton.isHidden = true
        scrollView.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 3).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: width - 190).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPhoneTextField() {
        phoneTextField = EditTextField(placeholder: "+7 (999) 111-22-33",
                                       source: .user,
                                       presenter: presenter)
        scrollView.addSubview(phoneTextField)
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: width - 190).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSpecLabel() {
        specLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        specLabel.textColor = .black
        specLabel.text = "Специализация"
        specLabel.textAlignment = .left
        scrollView.addSubview(specLabel)
        
        specLabel.translatesAutoresizingMaskIntoConstraints = false
        specLabel.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: 9).isActive = true
        specLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        specLabel.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        specLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupSpecTextField() {
        specTextField = EditTextField(placeholder: "Специализация",
                                      source: .spec,
                                      presenter: presenter)
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: specLabel.bottomAnchor, constant: 3).isActive = true
        specTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupLocationLabel() {
        locationLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        locationLabel.textColor = .black
        locationLabel.text = "Место жительства"
        locationLabel.textAlignment = .left
        scrollView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: specTextField.bottomAnchor, constant: 3).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupLocationTextField() {
        locationTextField = EditTextField(placeholder: "Субъект город",
                                          source: .user,
                                          presenter: presenter)
        scrollView.addSubview(locationTextField)
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 3).isActive = true
        locationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        locationTextField.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupWorkPlaceLabel() {
        workPlaceLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        workPlaceLabel.textColor = .black
        workPlaceLabel.text = "Место работы"
        workPlaceLabel.textAlignment = .left
        scrollView.addSubview(workPlaceLabel)
        
        workPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        workPlaceLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 3).isActive = true
        workPlaceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        workPlaceLabel.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        workPlaceLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupWorkPlace1TextField() {
        workPlace1TextField = EditTextField(placeholder: "Основное место работы",
                                            source: .job,
                                            presenter: presenter)
        scrollView.addSubview(workPlace1TextField)
        
        workPlace1TextField.translatesAutoresizingMaskIntoConstraints = false
        workPlace1TextField.topAnchor.constraint(equalTo: workPlaceLabel.bottomAnchor, constant: 3).isActive = true
        workPlace1TextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        workPlace1TextField.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        workPlace1TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupWorkPlace2TextField() {
        workPlace2TextField = EditTextField(placeholder: "Дополнительное место работы",
                                            source: .job,
                                            presenter: presenter)
        scrollView.addSubview(workPlace2TextField)
        
        workPlace2TextField.translatesAutoresizingMaskIntoConstraints = false
        workPlace2TextField.topAnchor.constraint(equalTo: workPlace1TextField.bottomAnchor, constant: 5).isActive = true
        workPlace2TextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        workPlace2TextField.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        workPlace2TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupAddWorkPlaceButton() {
        addWorkPlaceButton = PlusButton()
        addWorkPlaceButton.addTarget(self, action: #selector(addWorkPlusButtonPressed), for: .touchUpInside)
        view.addSubview(addWorkPlaceButton)
        
        addWorkPlaceButton.translatesAutoresizingMaskIntoConstraints = false
        addWorkPlaceButton.topAnchor.constraint(equalTo: workPlace2TextField.bottomAnchor,
                                                constant: 3).isActive = true
        addWorkPlaceButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                     constant: 30).isActive = true
        addWorkPlaceButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        addWorkPlaceButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupInterestsLabel() {
        interestsLabel.font = UIFont.boldSystemFontOfSize(size: 12)
        interestsLabel.textColor = .black
        interestsLabel.text = "Область научных интересов"
        interestsLabel.textAlignment = .left
        scrollView.addSubview(interestsLabel)
        
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        interestsLabel.topAnchor.constraint(equalTo: addWorkPlaceButton.bottomAnchor, constant: 3).isActive = true
        interestsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        interestsLabel.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        interestsLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupInterestsTextView() {
        interestsTextView = EditTextView()
        scrollView.addSubview(interestsTextView)
        
        interestsTextView.translatesAutoresizingMaskIntoConstraints = false
        interestsTextView.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor, constant: 3).isActive = true
        interestsTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        interestsTextView.widthAnchor.constraint(equalToConstant: width - 50).isActive = true
        interestsTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    private func addTapGestureToHideKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown​),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - IBActions
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    @objc func keyboardWasShown​(notification: Notification) {
        guard let info = notification.userInfo else {
            assertionFailure()
            return
        }
        //swiftlint:disable force_cast
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        keyboardHeight = kbSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: - Buttons methods
    @objc func photoButtonTapped(_ sender: UIButton) {
        let alertVC = UIAlertController(title: "Установить аватар",
                                        message: nil,
                                        preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отменить",
                                         style: .cancel,
                                         handler: nil)
        let takePhotoAction = UIAlertAction(title: "Сделать снимок",
                                            style: .default,
                                            handler: { _ in self.imagePicker.cameraAsscessRequest() })
        let choosePhotoAction = UIAlertAction(title: "Выбрать фотографию",
                                              style: .default,
                                              handler: { _ in self.imagePicker.photoGalleryAsscessRequest() })
        alertVC.addAction(cancelAction)
        alertVC.addAction(takePhotoAction)
        alertVC.addAction(choosePhotoAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func addWorkPlusButtonPressed() {
        
    }
    
    // MARK: - Navigation
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}

extension ProfileViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        userPhoto.image = image
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        imagePicker.dismiss()
    }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}
