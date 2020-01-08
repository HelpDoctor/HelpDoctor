//
//  CreateProfileSpecViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileSpecViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileSpecPresenterProtocol?
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let step6TitleLabel = UILabel()
    private let step6Label = UILabel()
    let specTextField = InterestsSearchTextField()
    private var specSearchButton = SearchButton()
    private let step7TitleLabel = UILabel()
    private let step7Label = UILabel()
    private var userPhoto = UIImageView()
    private lazy var imagePicker = ImagePicker()
    private let backButton = UIButton()
    private var saveButton = HDButton()
    private var keyboardHeight: CGFloat = 0
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupStep6TitleLabel()
        setupStep6Label()
        setupSpecTextField()
        setupSpecSearchButton()
        setupStep7TitleLabel()
        setupStep7Label()
        setupUserPhotoView()
        setupBackButton()
        setupSaveButton()
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width, height: height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupStep6TitleLabel() {
        step6TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step6TitleLabel.textColor = .white
        step6TitleLabel.text = "Шаг 6"
        step6TitleLabel.textAlignment = .center
        scrollView.addSubview(step6TitleLabel)
        
        step6TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step6TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        step6TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step6TitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setupStep6Label() {
        step6Label.font = UIFont.systemFontOfSize(size: 14)
        step6Label.textColor = .white
        //swiftlint:disable line_length
        step6Label.text = "Укажите область своих научных интересов. Если Вы не нашли нужное ключевое слово, добавьте своё"
        //swiftlint:enable line_length
        step6Label.textAlignment = .left
        step6Label.numberOfLines = 0
        scrollView.addSubview(step6Label)
        
        step6Label.translatesAutoresizingMaskIntoConstraints = false
        step6Label.topAnchor.constraint(equalTo: step6TitleLabel.bottomAnchor,
                                        constant: 8).isActive = true
        step6Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step6Label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step6Label.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func setupSpecTextField() {
        specTextField.presenter = presenter
        specTextField.font = UIFont.systemFontOfSize(size: 14)
        specTextField.textColor = .textFieldTextColor
        specTextField.layer.cornerRadius = 5
        scrollView.addSubview(specTextField)
        
        specTextField.translatesAutoresizingMaskIntoConstraints = false
        specTextField.topAnchor.constraint(equalTo: step6Label.bottomAnchor, constant: 81).isActive = true
        specTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        specTextField.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        specTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSpecSearchButton() {
        specSearchButton = SearchButton()
        specSearchButton.addTarget(self, action: #selector(specSearchButtonPressed), for: .touchUpInside)
        view.addSubview(specSearchButton)
        
        specSearchButton.translatesAutoresizingMaskIntoConstraints = false
        specSearchButton.topAnchor.constraint(equalTo: specTextField.topAnchor,
                                                constant: 5).isActive = true
        specSearchButton.trailingAnchor.constraint(equalTo: specTextField.trailingAnchor,
                                                     constant: -5).isActive = true
        specSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        specSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupStep7TitleLabel() {
        step7TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step7TitleLabel.textColor = .white
        step7TitleLabel.text = "Шаг 7"
        step7TitleLabel.textAlignment = .center
        scrollView.addSubview(step7TitleLabel)
        
        step7TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step7TitleLabel.topAnchor.constraint(equalTo: specTextField.bottomAnchor, constant: 15).isActive = true
        step7TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step7TitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setupStep7Label() {
        step7Label.font = UIFont.systemFontOfSize(size: 14)
        step7Label.textColor = .white
        step7Label.text = "Добавьте свою фотографию"
        step7Label.textAlignment = .left
        step7Label.numberOfLines = 0
        scrollView.addSubview(step7Label)
        
        step7Label.translatesAutoresizingMaskIntoConstraints = false
        step7Label.topAnchor.constraint(equalTo: step7TitleLabel.bottomAnchor,
                                        constant: 8).isActive = true
        step7Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7Label.widthAnchor.constraint(equalToConstant: width - 60).isActive = true
        step7Label.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupUserPhotoView() {
        let defaultImage = "Avatar.pdf"
        guard let image = UIImage(named: defaultImage) else {
            assertionFailure("Missing ​​\(defaultImage) asset")
            return
        }
        let imageSize: CGFloat = 150
        userPhoto.image = image
        scrollView.addSubview(userPhoto)
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.topAnchor.constraint(equalTo: step7Label.bottomAnchor,
                                        constant: 21).isActive = true
        userPhoto.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        userPhoto.layer.cornerRadius = imageSize / 2
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.masksToBounds = true
        
        let button = UIButton()
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        scrollView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: step7Label.bottomAnchor,
                                        constant: 21).isActive = true
        button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        button.layer.cornerRadius = imageSize / 2
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
    }
    
    private func setupBackButton() {
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        backButton.titleLabel?.textColor = .white
        backButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(backButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
        backButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: height - (bottomPadding ?? 0) - 98).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton = HDButton(title: "Готово", fontSize: 14)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.isEnabled = true
        view.addSubview(saveButton)
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
        constant: height - (bottomPadding ?? 0) - 92).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: width - 20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
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
    @objc private func specSearchButtonPressed() {
        presenter?.interestsSearch()
    }
    
    @objc private func saveButtonPressed() {
        presenter?.save()
    }
    
    @objc func photoButtonTapped(_ sender: UIButton) {
        let alertVC = UIAlertController(title: "Установить аватар",
                                        message: nil,
                                        preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена",
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
    
    // MARK: - Navigation
    @objc private func backButtonPressed() {
        presenter?.back()
    }
}

extension CreateProfileSpecViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        userPhoto.image = image
        presenter?.setPhoto(photoString: image.toString())
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}
