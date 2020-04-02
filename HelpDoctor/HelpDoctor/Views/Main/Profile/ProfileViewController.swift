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
    private let backgroundColor = UIColor.backgroundColor
    private let headerHeight = 40.f
    private let scrollView = UIScrollView()
    private let topView = UIImageView()
    private var userPhoto = UIImageView()
    private let verificationIcon = UIImageView()
    private let topStackView = UIView()
    private var nameLabel = UILabel()
    private var specLabel = UILabel()
    private let editButton = UIButton()
    private let generalPageButton = UIButton()
    private let educationPageButton = UIButton()
    private let careerPageButton = UIButton()
    private let interestsPageButton = UIButton()
    private let generalLineView = UIView()
    private let educationLineView = UIView()
    private let careerLineView = UIView()
    private let interestsLineView = UIView()
    private var generalView = ProfileGeneralView()
    private var educationView = ProfileEducationView()
    private var careerView = ProfileCareerView()
    private var interestsView = ProfileInterestsView()
//    private lazy var imagePicker = ImagePicker()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getUser()
//        imagePicker.delegate = self
        view.backgroundColor = backgroundColor
        setupScrollView()
        setupHeaderView(color: .searchBarTintColor, height: headerHeight, presenter: presenter)
        setupTopView()
        setupUserPhotoView()
        setupVerificationIcon()
        setupTopStackView()
        setupNameLabel()
        setupSpecLabel()
        setupEditButton()
        setupGeneralPageButton()
        setupEducationPageButton()
        setupCareerPageButton()
        setupInterestsPageButton()
        setupLines()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .searchBarTintColor)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    /// Установка аватара на форму
    /// - Parameter image: аватар
    func setImage(image: UIImage?) {
        let defaultImageName = "Avatar.pdf"
        guard let defaultImage = UIImage(named: defaultImageName) else {
            assertionFailure("Missing ​​\(defaultImageName) asset")
            return
        }
        userPhoto.image = image ?? defaultImage
    }
    
    /// Установка ФИО пользователя на форму
    /// - Parameter name: ФИО пользователя
    func setName(name: String) {
        nameLabel.text = name
    }
    
    /// Установка специализации пользователя на форму
    /// - Parameter spec: специализация пользователя
    func setSpec(spec: String) {
        specLabel.text = spec
    }
    
    /// Установка формы отображения общей информации
    func setupGeneralView() {
        guard let user = Session.instance.user else { return }
        generalView = ProfileGeneralView(user: user)
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.addTarget(self, action: #selector(educationPageButtonPressed))
        swipeRight.direction = .left
        generalView.addGestureRecognizer(swipeRight)
        scrollView.addSubview(generalView)
        
        generalView.translatesAutoresizingMaskIntoConstraints = false
        generalView.topAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        generalView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        generalView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        generalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Установка формы отображения информации об образовании
    func setupEducationView() {
        guard let user = Session.instance.user else { return }
        educationView = ProfileEducationView(user: user)
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.addTarget(self, action: #selector(careerPageButtonPressed))
        swipeRight.direction = .left
        educationView.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(generalPageButtonPressed))
        swipeLeft.direction = .right
        educationView.addGestureRecognizer(swipeLeft)
        educationView.isHidden = true
        scrollView.addSubview(educationView)
        
        educationView.translatesAutoresizingMaskIntoConstraints = false
        educationView.topAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        educationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        educationView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        educationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Установка формы отображения информации о карьере
    func setupCareerView() {
        guard let job = Session.instance.userJob else { return }
        careerView = ProfileCareerView(job: job)
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.addTarget(self, action: #selector(interestsPageButtonPressed))
        swipeRight.direction = .left
        careerView.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(educationPageButtonPressed))
        swipeLeft.direction = .right
        careerView.addGestureRecognizer(swipeLeft)
        careerView.isHidden = true
        scrollView.addSubview(careerView)
        
        careerView.translatesAutoresizingMaskIntoConstraints = false
        careerView.topAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        careerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        careerView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        careerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Установка формы отображения научных интересов
    func setupInterestsView() {
        guard let interests = Session.instance.userInterests else { return }
        interestsView = ProfileInterestsView(interests: interests)
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(careerPageButtonPressed))
        swipeLeft.direction = .right
        interestsView.addGestureRecognizer(swipeLeft)
        interestsView.isHidden = true
        scrollView.addSubview(interestsView)
        
        interestsView.translatesAutoresizingMaskIntoConstraints = false
        interestsView.topAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        interestsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        interestsView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        interestsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
    private func setupScrollView() {
        let heightScroll = Session.height - headerHeight - (tabBarController?.tabBar.frame.height ?? 0)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    /// Установка формы с бэкграундом под фото
    private func setupTopView() {
        topView.image = UIImage(named: "BackgroundProfile")
        scrollView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    /// Установка поля для аватара пользователя
    private func setupUserPhotoView() {
        let defaultImage = "Avatar"
        guard let image = UIImage(named: defaultImage) else {
            assertionFailure("Missing ​​\(defaultImage) asset")
            return
        }
        let imageSize = 120.f
        userPhoto.image = image
        scrollView.addSubview(userPhoto)
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        userPhoto.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        userPhoto.layer.borderWidth = 5
        userPhoto.layer.borderColor = UIColor.white.cgColor
        userPhoto.layer.cornerRadius = imageSize / 2
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.masksToBounds = true
        /*
        let button = UIButton()
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        scrollView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        button.layer.cornerRadius = imageSize / 2
        button.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
 */
    }
    
    /// Установка иконки верифицированный пользователь
    private func setupVerificationIcon() {
        let width = 30.f
        let trailing = 10.f
        let bottom = 4.f
        
        if Session.instance.userStatus == UserStatus.verified {
            verificationIcon.image = UIImage(named: "VerificationMark")
        } else {
            verificationIcon.image = UIImage(named: "NotVerificationMark")
        }
        
        scrollView.addSubview(verificationIcon)
        
        verificationIcon.translatesAutoresizingMaskIntoConstraints = false
        verificationIcon.bottomAnchor.constraint(equalTo: userPhoto.bottomAnchor,
                                                 constant: bottom).isActive = true
        verificationIcon.trailingAnchor.constraint(equalTo: userPhoto.trailingAnchor,
                                                   constant: -trailing).isActive = true
        verificationIcon.widthAnchor.constraint(equalToConstant: width).isActive = true
        verificationIcon.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка формы под отображение ФИО, специализации и кнопки редактирования профиля
    private func setupTopStackView() {
        let height = 50.f
        topStackView.backgroundColor = .searchBarTintColor
        scrollView.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topStackView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи отображения ФИО
    private func setupNameLabel() {
        let top = 4.f
        let leading = 20.f
        let height = 19.f
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFontOfSize(size: 14)
        topStackView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topStackView.topAnchor,
                                       constant: top).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                           constant: leading).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: Session.width - (leading * 2)).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи специализации
    private func setupSpecLabel() {
        let top = 4.f
        let leading = 20.f
        let height = 19.f
        specLabel.textColor = .white
        specLabel.textAlignment = .center
        specLabel.font = .systemFontOfSize(size: 14)
        topStackView.addSubview(specLabel)
        
        specLabel.translatesAutoresizingMaskIntoConstraints = false
        specLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                       constant: top).isActive = true
        specLabel.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                           constant: leading).isActive = true
        specLabel.widthAnchor.constraint(equalToConstant: Session.width - (leading * 2)).isActive = true
        specLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки редактирования / выхода их профиля
    private func setupEditButton() {
        let trailing = 7.f
        let width = 10.f
        let height = 20.f
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        editButton.setImage(UIImage(named: "EditDotsButton"), for: .normal)
        topStackView.addSubview(editButton)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.centerYAnchor.constraint(equalTo: topStackView.centerYAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                             constant: -trailing).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки Общее
    private func setupGeneralPageButton() {
        let height = 40.f
        generalPageButton.addTarget(self, action: #selector(generalPageButtonPressed), for: .touchUpInside)
        generalPageButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        generalPageButton.setTitle("Общее", for: .normal)
        scrollView.addSubview(generalPageButton)
        
        generalPageButton.translatesAutoresizingMaskIntoConstraints = false
        generalPageButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        generalPageButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        generalPageButton.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        generalPageButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки Образование
    private func setupEducationPageButton() {
        educationPageButton.addTarget(self, action: #selector(educationPageButtonPressed), for: .touchUpInside)
        educationPageButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        educationPageButton.setTitle("Образование", for: .normal)
        scrollView.addSubview(educationPageButton)
        
        educationPageButton.translatesAutoresizingMaskIntoConstraints = false
        educationPageButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        educationPageButton.leadingAnchor.constraint(equalTo: generalPageButton.trailingAnchor).isActive = true
        educationPageButton.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        educationPageButton.heightAnchor.constraint(equalTo: generalPageButton.heightAnchor).isActive = true
    }
    
    /// Установка кнопки Карьера
    private func setupCareerPageButton() {
        careerPageButton.addTarget(self, action: #selector(careerPageButtonPressed), for: .touchUpInside)
        careerPageButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        careerPageButton.setTitle("Карьера", for: .normal)
        scrollView.addSubview(careerPageButton)
        
        careerPageButton.translatesAutoresizingMaskIntoConstraints = false
        careerPageButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        careerPageButton.leadingAnchor.constraint(equalTo: educationPageButton.trailingAnchor).isActive = true
        careerPageButton.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        careerPageButton.heightAnchor.constraint(equalTo: generalPageButton.heightAnchor).isActive = true
    }
    
    /// Установка кнопки научные интересы
    private func setupInterestsPageButton() {
        interestsPageButton.addTarget(self, action: #selector(interestsPageButtonPressed), for: .touchUpInside)
        interestsPageButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        interestsPageButton.setTitle("Научные интересы", for: .normal)
        interestsPageButton.titleLabel?.numberOfLines = 2
        scrollView.addSubview(interestsPageButton)
        
        interestsPageButton.translatesAutoresizingMaskIntoConstraints = false
        interestsPageButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        interestsPageButton.leadingAnchor.constraint(equalTo: careerPageButton.trailingAnchor).isActive = true
        interestsPageButton.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        interestsPageButton.heightAnchor.constraint(equalTo: generalPageButton.heightAnchor).isActive = true
    }
    
    /// Установка линий отображения выбранной группы
    private func setupLines() {
        let height = 2.f
        generalLineView.backgroundColor = .hdButtonColor
        educationLineView.backgroundColor = .hdButtonColor
        careerLineView.backgroundColor = .hdButtonColor
        interestsLineView.backgroundColor = .hdButtonColor
        generalLineView.isHidden = false
        educationLineView.isHidden = true
        careerLineView.isHidden = true
        interestsLineView.isHidden = true
        scrollView.addSubview(generalLineView)
        scrollView.addSubview(educationLineView)
        scrollView.addSubview(careerLineView)
        scrollView.addSubview(interestsLineView)
        
        generalLineView.translatesAutoresizingMaskIntoConstraints = false
        generalLineView.bottomAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        generalLineView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        generalLineView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        generalLineView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        educationLineView.translatesAutoresizingMaskIntoConstraints = false
        educationLineView.bottomAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        educationLineView.leadingAnchor.constraint(equalTo: generalLineView.trailingAnchor).isActive = true
        educationLineView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        educationLineView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        careerLineView.translatesAutoresizingMaskIntoConstraints = false
        careerLineView.bottomAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        careerLineView.leadingAnchor.constraint(equalTo: educationLineView.trailingAnchor).isActive = true
        careerLineView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        careerLineView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        interestsLineView.translatesAutoresizingMaskIntoConstraints = false
        interestsLineView.bottomAnchor.constraint(equalTo: generalPageButton.bottomAnchor).isActive = true
        interestsLineView.leadingAnchor.constraint(equalTo: careerLineView.trailingAnchor).isActive = true
        interestsLineView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.25).isActive = true
        interestsLineView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        scrollView.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - IBActions
    
    // MARK: - Buttons methods
    @objc private func editButtonPressed() {
        let popoverContentController = ProfilePopoverController()
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 180, height: 100)
        popoverContentController.delegate = self
        if let ppc = popoverContentController.popoverPresentationController {
            ppc.delegate = self
        }
        self.present(popoverContentController, animated: true, completion: nil)
    }
    
    /// Изменение отображения информации о пользователе при нажатии на кнопку Общее
    @objc private func generalPageButtonPressed() {
        generalLineView.isHidden = false
        educationLineView.isHidden = true
        careerLineView.isHidden = true
        interestsLineView.isHidden = true
        
        generalView.isHidden = false
        educationView.isHidden = true
        careerView.isHidden = true
        interestsView.isHidden = true
    }
    
    /// Изменение отображения информации о пользователе при нажатии на кнопку Образование
    @objc private func educationPageButtonPressed() {
        generalLineView.isHidden = true
        educationLineView.isHidden = false
        careerLineView.isHidden = true
        interestsLineView.isHidden = true
        
        generalView.isHidden = true
        educationView.isHidden = false
        careerView.isHidden = true
        interestsView.isHidden = true
    }
    
    /// Изменение отображения информации о пользователе при нажатии на кнопку Карьера
    @objc private func careerPageButtonPressed() {
        generalLineView.isHidden = true
        educationLineView.isHidden = true
        careerLineView.isHidden = false
        interestsLineView.isHidden = true
        
        generalView.isHidden = true
        educationView.isHidden = true
        careerView.isHidden = false
        interestsView.isHidden = true
    }
    
    /// Изменение отображения информации о пользователе при нажатии на кнопку Научные интересы
    @objc private func interestsPageButtonPressed() {
        generalLineView.isHidden = true
        educationLineView.isHidden = true
        careerLineView.isHidden = true
        interestsLineView.isHidden = false
        
        generalView.isHidden = true
        educationView.isHidden = true
        careerView.isHidden = true
        interestsView.isHidden = false
    }
    
    // MARK: - Navigation
    /// Переход на предыдущий экран
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ProfileViewController: UIPopoverPresentationControllerDelegate {
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = .any
        popoverPresentationController.sourceView = editButton
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

// MARK: - ProfilePopoverDelegate
extension ProfileViewController: ProfilePopoverDelegate {
    
    func logout() {
        presenter?.logout()
    }
    
}
/*
// MARK: - ImagePickerDelegate
extension ProfileViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        userPhoto.image = image
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
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    /// Выбор фотографии при нажатии на аватар
    /// - Parameter sender:
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
    
    func getUserPhoto() -> UIImage? {
        return userPhoto.image
    }
    
}
*/
