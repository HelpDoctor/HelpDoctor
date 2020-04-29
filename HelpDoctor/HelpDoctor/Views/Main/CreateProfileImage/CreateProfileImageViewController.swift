//
//  CreateProfileImageViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileImageViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: CreateProfileImagePresenterProtocol?
    
    // MARK: - Constants
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 60.f
    private let step9TitleLabel = UILabel()
    private let step9Label = UILabel()
    private let subscriptLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let addButton = UIButton()
    private let nextButton = HDButton(title: "Готово")
    private let contentWidth = Session.width - 40
    private var userPhoto = UIImageView()
    private lazy var imagePicker = ImagePicker()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = backgroundColor
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupStep9TitleLabel()
        setupStep9Label()
        setupUserPhotoView()
        setupNextButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Setup views
    private func setupStep9TitleLabel() {
        let height = 20.f
        step9TitleLabel.backgroundColor = .searchBarTintColor
        step9TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step9TitleLabel.textColor = .white
        step9TitleLabel.text = "Шаг 9"
        step9TitleLabel.textAlignment = .center
        view.addSubview(step9TitleLabel)
        
        step9TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step9TitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: headerHeight).isActive = true
        step9TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        step9TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step9TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupStep9Label() {
        let text =
        """
        Добавьте свою фотографию
        """
        let top = 20.f
        let height = text.height(withConstrainedWidth: contentWidth, font: .systemFontOfSize(size: 14))
        step9Label.numberOfLines = 0
        step9Label.font = .systemFontOfSize(size: 14)
        step9Label.textColor = .white
        step9Label.text = text
        step9Label.textAlignment = .left
        view.addSubview(step9Label)
        
        step9Label.translatesAutoresizingMaskIntoConstraints = false
        step9Label.topAnchor.constraint(equalTo: step9TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step9Label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        step9Label.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        step9Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupUserPhotoView() {
        let defaultImage = "Avatar.pdf"
        guard let image = UIImage(named: defaultImage) else {
            assertionFailure("Missing ​​\(defaultImage) asset")
            return
        }
        let top = 11.f
        let imageSize = 200.f
        userPhoto.image = image
        view.addSubview(userPhoto)
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.topAnchor.constraint(equalTo: step9Label.bottomAnchor,
                                       constant: top).isActive = true
        userPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        userPhoto.layer.cornerRadius = imageSize / 2
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.masksToBounds = true
        
        let button = UIButton()
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: step9Label.bottomAnchor,
                                    constant: top).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        button.layer.cornerRadius = imageSize / 2
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 110.f
        let height = 40.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: step9TitleLabel.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    // MARK: - IBActions
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Buttons methods
    @objc private func nextButtonPressed() {
        presenter?.save()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
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
    
}

extension CreateProfileImageViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        userPhoto.image = image
        presenter?.setPhoto(photoString: image.toString())
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
