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
    
    // MARK: - Constants and variables
    private let session = Session.instance
    private let scrollView = UIScrollView()
    private var headerView = ProfileHeaderView()
    private var nameTextField = EditTextField()
    private var userPhoto = UIImageView()
    private let birthDateLabel = UILabel()
    private var birthDateTextField = EditTextField()
    private let contactsLabel = UILabel()
    private var emailTextField = EditTextField()
    private var phoneTextField = EditTextField()
    private let specLabel = UILabel()
    private var specTextField = MedicalSpecializationSearchTextField()
    private var editMainSpecButton = EditButton()
    private let locationLabel = UILabel()
    private var locationTextField = CitiesSearchTextField()
    private var editLocationButton = EditButton()
    private let workPlaceLabel = UILabel()
    private var workPlace1TextField = MedicalOrganizationSearchTextField()
    private var editMainJobButton = EditButton()
    private var workPlace2TextField = MedicalOrganizationSearchTextField()
    private var editAddJobButton = EditButton()
    private var addWorkPlaceButton = PlusButton()
    private let interestsLabel = UILabel()
    private var interestsTextView = UITextView()
    private var editInterestsButton = EditButton()
    private lazy var imagePicker = ImagePicker()
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getUser()
        imagePicker.delegate = self
        setupBackground()
        setupScrollView()
        setupProfileHeaderView()
        setupNameTextField()
        setupUserPhotoView()
        setupBirthDateLabel()
        setupBirthDateTextField()
        setupContactsLabel()
        setupEmailTextField()
        setupPhoneTextField()
        setupSpecLabel()
        setupSpecTextField()
        setupEditMainSpecButton()
        setupLocationLabel()
        setupLocationTextField()
        setupEditLocationButton()
        setupWorkPlaceLabel()
        setupWorkPlace1TextField()
        setupEditMainJobButton()
        setupWorkPlace2TextField()
        setupEditAddJobButton()
        setupAddWorkPlaceButton()
        setupInterestsLabel()
        setupInterestsTextView()
        setupEditInterestsButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
        UIApplication.statusBarBackgroundColor = .tabBarColor
    }
    
    // MARK: - Public methods
    func setImage(image: UIImage?) {
        let defaultImageName = "Avatar.pdf"
        guard let defaultImage = UIImage(named: defaultImageName) else {
            assertionFailure("Missing ​​\(defaultImageName) asset")
            return
        }
        headerView.userImage.image = image ?? defaultImage
        userPhoto.image = image ?? defaultImage
    }
    
    func getUserPhoto() -> UIImage? {
        return userPhoto.image
    }
    
    func setName(name: String) {
        nameTextField.textField.text = name
    }
    
    func getName() -> String? {
        return nameTextField.textField.text
    }
    
    func setBirthday(birthday: String) {
        birthDateTextField.textField.text = birthday
    }
    
    func getBirthday() -> String? {
        return birthDateTextField.textField.text
    }
    
    func setEmail(email: String) {
        emailTextField.textField.text = email
    }
    
    func setPhone(phone: String) {
        phoneTextField.textField.text = phone
    }
    
    func getPhone() -> String? {
        return phoneTextField.textField.text
    }
    
    func setSpec(spec: String) {
        specTextField.text = spec
    }
    
    func setLocation(location: String) {
        locationTextField.text = location
    }
    
    func setMainJob(job: String) {
        workPlace1TextField.text = job
    }
    
    func setAddJob(job: String) {
        workPlace2TextField.text = job
    }
    
    func setInterests(interest: String) {
        interestsTextView.text = interest
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: session.width, height: session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupProfileHeaderView() {
        headerView = ProfileHeaderView(title: "Мой профиль",
                                       text: nil,
                                       userImage: nil,
                                       presenter: presenter)
        scrollView.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalToConstant: session.width).isActive = true
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
        nameTextField.widthAnchor.constraint(equalToConstant: session.width - 50).isActive = true
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
        birthDateLabel.widthAnchor.constraint(equalToConstant: session.width - 190).isActive = true
        birthDateLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupBirthDateTextField() {
        birthDateTextField = EditTextField(placeholder: "ДД.ММ.ГГГГ",
                                           source: .user,
                                           presenter: presenter)
        birthDateTextField.textField.delegate = self
        birthDateTextField.textField.keyboardType = .numberPad
        scrollView.addSubview(birthDateTextField)
        
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        birthDateTextField.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 3).isActive = true
        birthDateTextField.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        birthDateTextField.widthAnchor.constraint(equalToConstant: session.width - 190).isActive = true
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
        contactsLabel.widthAnchor.constraint(equalToConstant: session.width - 190).isActive = true
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
        emailTextField.widthAnchor.constraint(equalToConstant: session.width - 190).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPhoneTextField() {
        phoneTextField = EditTextField(placeholder: "+7 (999) 111-22-33",
                                       source: .user,
                                       presenter: presenter)
        phoneTextField.textField.delegate = self
        phoneTextField.textField.keyboardType = .numberPad
        scrollView.addSubview(phoneTextField)
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 30).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: session.width - 190).isActive = true
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
        specLabel.widthAnchor.constraint(equalToConstant: session.width - 50).isActive = true
        specLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupSpecTextField() {
        specTextField.presenter = presenter
        specTextField.mainSpec = true
        specTextField.textColor = .black
        specTextField.isEnabled = false
        specTextField.layer.cornerRadius = 5
        specTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        specTextField.font = .systemFontOfSize(size: 12)
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: specLabel.bottomAnchor, constant: 3).isActive = true
        specTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: session.width - 80).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupEditMainSpecButton() {
        editMainSpecButton = EditButton()
        editMainSpecButton.addTarget(self, action: #selector(editMainSpecButtonPressed), for: .touchUpInside)
        editMainSpecButton.backgroundColor = .white
        editMainSpecButton.layer.cornerRadius = 5
        editMainSpecButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(editMainSpecButton)
        
        editMainSpecButton.translatesAutoresizingMaskIntoConstraints = false
        editMainSpecButton.topAnchor.constraint(equalTo: specLabel.bottomAnchor,
                                                constant: 3).isActive = true
        editMainSpecButton.leadingAnchor.constraint(equalTo: specTextField.trailingAnchor).isActive = true
        editMainSpecButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editMainSpecButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        locationLabel.widthAnchor.constraint(equalToConstant: session.width - 50).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupLocationTextField() {
        locationTextField.presenter = presenter
        locationTextField.textColor = .black
        locationTextField.isEnabled = false
        locationTextField.layer.cornerRadius = 5
        locationTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        locationTextField.font = .systemFontOfSize(size: 12)
        scrollView.addSubview(locationTextField)
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 3).isActive = true
        locationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        locationTextField.widthAnchor.constraint(equalToConstant: session.width - 80).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupEditLocationButton() {
        editLocationButton = EditButton()
        editLocationButton.addTarget(self, action: #selector(editLocationButtonPressed), for: .touchUpInside)
        editLocationButton.backgroundColor = .white
        editLocationButton.layer.cornerRadius = 5
        editLocationButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(editLocationButton)
        
        editLocationButton.translatesAutoresizingMaskIntoConstraints = false
        editLocationButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,
                                                constant: 3).isActive = true
        editLocationButton.leadingAnchor.constraint(equalTo: locationTextField.trailingAnchor).isActive = true
        editLocationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editLocationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        workPlaceLabel.widthAnchor.constraint(equalToConstant: session.width - 50).isActive = true
        workPlaceLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupWorkPlace1TextField() {
        workPlace1TextField.presenter = presenter
        workPlace1TextField.mainWork = true
        workPlace1TextField.textColor = .black
        workPlace1TextField.isEnabled = false
        workPlace1TextField.layer.cornerRadius = 5
        workPlace1TextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        workPlace1TextField.font = .systemFontOfSize(size: 12)
        scrollView.addSubview(workPlace1TextField)
        
        workPlace1TextField.translatesAutoresizingMaskIntoConstraints = false
        workPlace1TextField.topAnchor.constraint(equalTo: workPlaceLabel.bottomAnchor, constant: 3).isActive = true
        workPlace1TextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        workPlace1TextField.widthAnchor.constraint(equalToConstant: session.width - 80).isActive = true
        workPlace1TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupEditMainJobButton() {
        editMainJobButton = EditButton()
        editMainJobButton.addTarget(self, action: #selector(editMainJobButtonPressed), for: .touchUpInside)
        editMainJobButton.backgroundColor = .white
        editMainJobButton.layer.cornerRadius = 5
        editMainJobButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(editMainJobButton)
        
        editMainJobButton.translatesAutoresizingMaskIntoConstraints = false
        editMainJobButton.topAnchor.constraint(equalTo: workPlaceLabel.bottomAnchor,
                                                constant: 3).isActive = true
        editMainJobButton.leadingAnchor.constraint(equalTo: workPlace1TextField.trailingAnchor).isActive = true
        editMainJobButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editMainJobButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupWorkPlace2TextField() {
        workPlace2TextField.presenter = presenter
        workPlace2TextField.mainWork = false
        workPlace2TextField.textColor = .black
        workPlace2TextField.isEnabled = false
        workPlace2TextField.layer.cornerRadius = 5
        workPlace2TextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        workPlace2TextField.font = .systemFontOfSize(size: 12)
        scrollView.addSubview(workPlace2TextField)
        
        workPlace2TextField.translatesAutoresizingMaskIntoConstraints = false
        workPlace2TextField.topAnchor.constraint(equalTo: workPlace1TextField.bottomAnchor, constant: 5).isActive = true
        workPlace2TextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        workPlace2TextField.widthAnchor.constraint(equalToConstant: session.width - 80).isActive = true
        workPlace2TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupEditAddJobButton() {
        editAddJobButton = EditButton()
        editAddJobButton.addTarget(self, action: #selector(editAddJobButtonPressed), for: .touchUpInside)
        editAddJobButton.backgroundColor = .white
        editAddJobButton.layer.cornerRadius = 5
        editAddJobButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(editAddJobButton)
        
        editAddJobButton.translatesAutoresizingMaskIntoConstraints = false
        editAddJobButton.topAnchor.constraint(equalTo: workPlace1TextField.bottomAnchor,
                                                constant: 5).isActive = true
        editAddJobButton.leadingAnchor.constraint(equalTo: workPlace2TextField.trailingAnchor).isActive = true
        editAddJobButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editAddJobButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        interestsLabel.widthAnchor.constraint(equalToConstant: session.width - 50).isActive = true
        interestsLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupInterestsTextView() {
        interestsTextView.textColor = .black
        interestsTextView.isEditable = false
        interestsTextView.layer.cornerRadius = 5
        interestsTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        interestsTextView.font = .systemFontOfSize(size: 12)
        scrollView.addSubview(interestsTextView)
        
        interestsTextView.translatesAutoresizingMaskIntoConstraints = false
        interestsTextView.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor, constant: 3).isActive = true
        interestsTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        interestsTextView.widthAnchor.constraint(equalToConstant: session.width - 80).isActive = true
        interestsTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupEditInterestsButton() {
        editInterestsButton = EditButton()
        editInterestsButton.addTarget(self, action: #selector(editInterestsButtonPressed), for: .touchUpInside)
        editInterestsButton.backgroundColor = .white
        editInterestsButton.layer.cornerRadius = 5
        editInterestsButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(editInterestsButton)
        
        editInterestsButton.translatesAutoresizingMaskIntoConstraints = false
        editInterestsButton.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor,
                                                constant: 3).isActive = true
        editInterestsButton.leadingAnchor.constraint(equalTo: interestsTextView.trailingAnchor).isActive = true
        editInterestsButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editInterestsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    @objc func editMainJobButtonPressed() {
        if workPlace1TextField.isEnabled {
            workPlace1TextField.isEnabled = false
            editMainJobButton.setImage(UIImage(named: "Edit_Button.pdf"), for: .normal)
            presenter?.save(source: .job)
        } else {
            workPlace1TextField.isEnabled = true
            if #available(iOS 13.0, *) {
                editMainJobButton.setImage(UIImage(named: "Save.pdf")?.withTintColor(.textFieldTextColor), for: .normal)
            } else {
                editMainJobButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
            }
        }
    }
    
    @objc func editAddJobButtonPressed() {
        if workPlace2TextField.isEnabled {
            workPlace2TextField.isEnabled = false
            editAddJobButton.setImage(UIImage(named: "Edit_Button.pdf"),
                                      for: .normal)
            presenter?.save(source: .job)
        } else {
            workPlace2TextField.isEnabled = true
            if #available(iOS 13.0, *) {
                editAddJobButton.setImage(UIImage(named: "Save.pdf")?.withTintColor(.textFieldTextColor),
                                          for: .normal)
            } else {
                editAddJobButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
            }
        }
    }
    
    @objc func editMainSpecButtonPressed() {
        if specTextField.isEnabled {
            specTextField.isEnabled = false
            editMainSpecButton.setImage(UIImage(named: "Edit_Button.pdf"), for: .normal)
            presenter?.save(source: .spec)
        } else {
            specTextField.isEnabled = true
            if #available(iOS 13.0, *) {
                editMainSpecButton.setImage(UIImage(named: "Save.pdf")?.withTintColor(.textFieldTextColor),
                                            for: .normal)
            } else {
                editMainSpecButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
            }
        }
    }
    
    @objc func editLocationButtonPressed() {
        if locationTextField.isEnabled {
            locationTextField.isEnabled = false
            editLocationButton.setImage(UIImage(named: "Edit_Button.pdf"), for: .normal)
            presenter?.save(source: .user)
        } else {
            locationTextField.isEnabled = true
            if #available(iOS 13.0, *) {
                editLocationButton.setImage(UIImage(named: "Save.pdf")?.withTintColor(.textFieldTextColor),
                                            for: .normal)
            } else {
                editLocationButton.setImage(UIImage(named: "Save.pdf"), for: .normal)
            }
        }
    }
    
    @objc func editInterestsButtonPressed() {
        presenter?.editInterests()
    }
    
    // MARK: - Navigation
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}

extension ProfileViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        userPhoto.image = image
        headerView.userImage.image = image
        presenter?.save(source: .user)
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
//swiftlint:disable force_unwrapping
extension ProfileViewController: UITextFieldDelegate {
    // MARK: - text field masking
    internal func textField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool {
        
        // MARK: - If Delete button click
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 {
            textField.text!.removeLast()
            return false
        }
        
        if textField == birthDateTextField.textField {
            if (textField.text?.count)! == 2 {
                textField.text = "\(textField.text!)."
            } else if (textField.text?.count)! == 5 {
                textField.text = "\(textField.text!)."
            } else if (textField.text?.count)! > 9 {
                return false
            }
        } else if textField == phoneTextField.textField {
            if (textField.text?.count)! == 1 {
                textField.text = "+\(textField.text!) ("
            } else if (textField.text?.count)! == 7 {
                textField.text = "\(textField.text!)) "
            } else if (textField.text?.count)! == 12 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! == 15 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! > 17 {
                return false
            }
        }
        return true
    }
}
