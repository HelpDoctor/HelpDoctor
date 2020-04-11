//
//  VerificationErrorViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class VerificationErrorViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: VerificationErrorPresenterProtocol?
    var messageFromServer: String?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let cloudImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let topLabel = UILabel()
    private let label = UILabel()
    private let commentTextView = UITextView()
    private let addFileTextField = UITextField()
    private let subscriptLabel = UILabel()
    private let sendButton = HDButton(title: "Отправить")
    private let backButton = BackButton()
    private var sourceFile: URL?
    private var keyboardHeight = 0.f
    private var heightCloudImage = 0.f
    
    private var topConstraintImage: NSLayoutConstraint?
    private var widthConstraintImage: NSLayoutConstraint?
    private var heightConstraintImage: NSLayoutConstraint?
    private var heightConstraintLabel: NSLayoutConstraint?
    private var topConstraintSendButton: NSLayoutConstraint?
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupLogoImage()
        setupDoctorsImage()
        setupCloudImage()
        setupTitleLabel()
        setupSubtitleLabel()
        setupTopLabel()
        setupLabel()
        setupCommentTextView()
        setupAddFileTextField()
        setupSubscriptLabel()
        setupSendButton()
        if #available(iOS 13.0, *) {} else {
            setupBackButton()
        }
        addTapGestureToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    func authorized() {
        titleLabel.textColor = .white
        subtitleLabel.textColor = .hdButtonColor
        subtitleLabel.text = "На рассмотрении"
        label.text =
        """
        Спасибо за предоставленную информацию!\n
        Пожалуйста, дождитесь результатов верификации. \
        Мы уведомим Вас о завершении процедуры проверки по указанному Вами адресу электронной почты
        """
        sendButton.setTitle("Ок", for: .normal)
        cloudImage.isHidden = true
        topLabel.isHidden = true
        addFileTextField.isHidden = true
        subscriptLabel.isHidden = true
        commentTextView.isHidden = true
        setupVerificationEndImage()
    }
    
    // MARK: - Setup views
    /// Установка ScrollView
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    /// Установка логотипа приложения
    private func setupLogoImage() {
        let top = 10.f
        let leading = Session.width - top
        let width = 50.f
        let imageName = "Logo.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        logoImage.image = image
        scrollView.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                       constant: top).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка картинки
    private func setupDoctorsImage() {
        let top = 25.f
        let width = Session.width - 140
        let imageName = "VerificationError.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        scrollView.addSubview(doctorsImage)
        
        doctorsImage.translatesAutoresizingMaskIntoConstraints = false
        topConstraintImage = doctorsImage.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                                               constant: top)
        topConstraintImage?.isActive = true
        doctorsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        widthConstraintImage = doctorsImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width)
        widthConstraintImage?.isActive = true
        heightConstraintImage = doctorsImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height)
        heightConstraintImage?.isActive = true
    }
    
    private func setupCloudImage() {
        let top = 10.f
        let width = Session.width - 70
        let imageName = "Cloud"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        cloudImage.image = resizedImage
        heightCloudImage = resizedImage.size.height
        scrollView.addSubview(cloudImage)
        
        cloudImage.translatesAutoresizingMaskIntoConstraints = false
        cloudImage.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                        constant: -top).isActive = true
        cloudImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cloudImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        cloudImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = heightCloudImage * (26 / 70)
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .hdRedColor
        titleLabel.text = "Верификация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: cloudImage.topAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка подзаголовка
    private func setupSubtitleLabel() {
        let bottom = heightCloudImage * (6 / 70)
        let height = 17.f
        subtitleLabel.font = .mediumSystemFontOfSize(size: 14)
        subtitleLabel.textColor = .hdRedColor
        subtitleLabel.text = "Не пройдена"
        subtitleLabel.textAlignment = .center
        scrollView.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.bottomAnchor.constraint(equalTo: cloudImage.bottomAnchor,
                                              constant: -bottom).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTopLabel() {
        let top = 5.f
        let height = 17.f
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "При верификации возникли сложности"
        topLabel.textAlignment = .center
        scrollView.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: cloudImage.bottomAnchor,
                                      constant: top).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка описания
    private func setupLabel() {
        let top = 4.f
        let width = Session.width - 22.f
        let height = 70.f
        label.font = .systemFontOfSize(size: 14)
        label.textColor = .white
        label.text =
        """
        Пожалуйста, учтите рекомендации администраторов приложения, \
        указанные в поле ниже, и направьте свои документы на повторную проверку в этом же окне
        """
        label.textAlignment = .left
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                   constant: top).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        heightConstraintLabel = label.heightAnchor.constraint(equalToConstant: height)
        heightConstraintLabel?.isActive = true
    }
    
    private func setupCommentTextView() {
        let top = 15.f
        let width = Session.width - 40
        let height = 50.f
        commentTextView.textAlignment = .left
        commentTextView.font = .systemFontOfSize(size: 14)
        commentTextView.textColor = .black
        commentTextView.layer.cornerRadius = 5
        commentTextView.delegate = self
        commentTextView.text = messageFromServer?.htmlAttributedString?.string
        commentTextView.textColor = .lightGray
        scrollView.addSubview(commentTextView)
        
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.topAnchor.constraint(equalTo: label.bottomAnchor,
                                             constant: top).isActive = true
        commentTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        commentTextView.widthAnchor.constraint(equalToConstant: width).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода электронной почты
    private func setupAddFileTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(addFileTextFieldPressed))
        let top = 15.f
        let width = Session.width - 114.f
        let height = 30.f
        addFileTextField.font = .systemFontOfSize(size: 14)
        addFileTextField.keyboardType = .emailAddress
        addFileTextField.autocapitalizationType = .none
        addFileTextField.autocorrectionType = .no
        addFileTextField.textColor = .textFieldTextColor
        addFileTextField.placeholder = "Прикрепить файл"
        addFileTextField.textAlignment = .left
        addFileTextField.backgroundColor = .white
        addFileTextField.layer.cornerRadius = 5
        addFileTextField.leftView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 8,
                                                         height: addFileTextField.frame.height))
        addFileTextField.leftViewMode = .always
        addFileTextField.addGestureRecognizer(tap)
        scrollView.addSubview(addFileTextField)
        
        addFileTextField.translatesAutoresizingMaskIntoConstraints = false
        addFileTextField.topAnchor.constraint(equalTo: commentTextView.bottomAnchor,
                                              constant: top).isActive = true
        addFileTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addFileTextField.widthAnchor.constraint(equalToConstant: width).isActive = true
        addFileTextField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка текста под полем ввода
    private func setupSubscriptLabel() {
        let width = Session.width - 114.f
        let height = 11.f
        subscriptLabel.font = .systemFontOfSize(size: 9)
        subscriptLabel.textColor = .white
        subscriptLabel.text = "Поддерживаемые форматы: pdf или jpg, png"
        subscriptLabel.textAlignment = .left
        subscriptLabel.numberOfLines = 0
        scrollView.addSubview(subscriptLabel)
        
        subscriptLabel.translatesAutoresizingMaskIntoConstraints = false
        subscriptLabel.topAnchor.constraint(equalTo: addFileTextField.bottomAnchor).isActive = true
        subscriptLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subscriptLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        subscriptLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Отправить"
    private func setupSendButton() {
        let top = 20.f
        let width = 150.f
        let height = 35.f
        sendButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        topConstraintSendButton = sendButton.topAnchor.constraint(equalTo: addFileTextField.bottomAnchor,
                                                                  constant: top)
        topConstraintSendButton?.isActive = true
    }
    
    /// Установка кнопки назад
    private func setupBackButton() {
        let leading = 8.f
        let top = 10.f
        let width = 57.f
        let height = 21.f
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
        backButton.addGestureRecognizer(tap)
        scrollView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                        constant: top).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка картинки
    private func setupVerificationEndImage() {
        let topSendButton = 26.f
        let heightLabel = 101.f
        let width = Session.width - 30
        let imageName = "VerificationImage.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        scrollView.addSubview(doctorsImage)
        
        topConstraintImage?.isActive = false
        widthConstraintImage?.isActive = false
        heightConstraintImage?.isActive = false
        heightConstraintLabel?.isActive = false
        topConstraintSendButton?.isActive = false
        doctorsImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        doctorsImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        doctorsImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
        label.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        sendButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: topSendButton).isActive = true
    }
    
    /// Добавление распознавания касания экрана
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
    /// Скрытие клавиатуры
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    /// Изменение размера ScrollView при появлении клавиатуры
    /// - Parameter notification: событие появления клавиатуры
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
    
    /// Изменение размера ScrollView при скрытии клавиатуры
    /// - Parameter notification: событие скрытия клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func addFileTextFieldPressed() {
        let documentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPickerViewController.delegate = self
        present(documentPickerViewController, animated: true) { }
    }
    
    // MARK: - Buttons methods
    /// Обработка нажатия кнопки "Отправить"
    @objc private func registerButtonPressed() {
        if sendButton.isSelected {
            presenter?.back()
        } else {
            guard let url = sourceFile else {
                self.showAlert(message: "Ошибка")
                return
            }
            presenter?.send(src: url)
            sendButton.isSelected = true
        }
    }
    
    /// Обработка нажатия кнопки "Назад"
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}

// MARK: - UIDocumentPickerDelegate
extension VerificationErrorViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentAt url: URL) {
        addFileTextField.text = url.lastPathComponent
        sourceFile = url
    }
    
}

// MARK: - UITextViewDelegate
extension VerificationErrorViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Поле для комментария"
            && textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Поле для комментария"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
}
