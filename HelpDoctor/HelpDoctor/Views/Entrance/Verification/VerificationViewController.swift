//
//  VerificationViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: VerificationPresenterProtocol?
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let logoImage = UIImageView()
    private let doctorsImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let label = UITextView()//UILabel()
    private let addFileTextField = UITextField()
    private let subscriptLabel = UILabel()
    private let sendButton = HDButton(title: "Отправить на \nпроверку")
    private let backButton = BackButton()
    private var sourceFile: URL?
    private var keyboardHeight: CGFloat = 0
    private var sendButtonTop: NSLayoutConstraint?
    private var sendButtonWidth: NSLayoutConstraint?
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        setupLogoImage()
        setupDoctorsImage()
        setupTitleLabel()
        setupLabel()
        setupAddFileTextField()
        setupSubscriptLabel()
        setupSendButton()
        addTapGestureToHideKeyboard()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Public methods
    func authorized() {
        let top = 26.f
        let width = 110.f
        let font = UIFont.systemFontOfSize(size: 14)
        let text =
        """
        Спасибо за предоставленную информацию!\n
        Пожалуйста, дождитесь результатов верификации. \
        Мы уведомим Вас о завершении процедуры проверки по указанному Вами адресу электронной почты
        """
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        let myString = NSMutableAttributedString(string: text, attributes: attributes)
        label.attributedText = myString
        sendButton.setTitle("Ок", for: .normal)
        sendButton.titleLabel?.font = .boldSystemFontOfSize(size: 18)
        addFileTextField.isHidden = true
        subscriptLabel.isHidden = true
        setupSubtitleLabel()
        sendButtonTop?.isActive = false
        sendButtonWidth?.isActive = false
        sendButtonWidth = sendButton.widthAnchor.constraint(equalToConstant: width)
        sendButtonTop = sendButton.topAnchor.constraint(equalTo: label.bottomAnchor,
                                                        constant: top)
        sendButtonTop?.isActive = true
        sendButtonWidth?.isActive = true
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
        let width = Session.width - 30
        let imageName = "VerificationImage.pdf"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        let resizedImage = image.resizeImage(width, opaque: false)
        doctorsImage.image = resizedImage
        scrollView.addSubview(doctorsImage)
        
        doctorsImage.translatesAutoresizingMaskIntoConstraints = false
        doctorsImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        doctorsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        doctorsImage.widthAnchor.constraint(equalToConstant: resizedImage.size.width).isActive = true
        doctorsImage.heightAnchor.constraint(equalToConstant: resizedImage.size.height).isActive = true
    }
    
    /// Установка заголовка
    private func setupTitleLabel() {
        let top = 5.f
        let height = 22.f
        titleLabel.font = .boldSystemFontOfSize(size: 18)
        titleLabel.textColor = .white
        titleLabel.text = "Верификация"
        titleLabel.textAlignment = .center
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: doctorsImage.bottomAnchor,
                                        constant: top).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка подзаголовка
    private func setupSubtitleLabel() {
        let top = 5.f
        let height = 17.f
        subtitleLabel.font = .mediumSystemFontOfSize(size: 14)
        subtitleLabel.textColor = .hdButtonColor
        subtitleLabel.text = "На рассмотрении"
        subtitleLabel.textAlignment = .center
        scrollView.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: top).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка описания
    private func setupLabel() {
        let top = 38.f
        let width = Session.width - 20.f
        guard let iconImage = UIImage(named: "Info") else { return }
        let font = UIFont.systemFontOfSize(size: 14)
        let attachment = NSTextAttachment()
        attachment.bounds = CGRect(x: 0,
                                   y: (font.capHeight - iconImage.size.height).rounded() / 2,
                                   width: iconImage.size.width,
                                   height: iconImage.size.height)
        attachment.image = iconImage
        let attachmentString = NSAttributedString(attachment: attachment)
        let text =
        """
        Чтобы получить доступ к полному функционалу приложения, \
        Вам необходимо предоставить копию документа, \
        подтверждающего вашу квалификацию - диплом о среднем или высшем медицинском образовании 
        """
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        let myString = NSMutableAttributedString(string: text, attributes: attributes)
        myString.append(attachmentString)
        let recognizer = AttachmentTapGestureRecognizer(target: self, action: #selector(handleAttachmentTap(_:)))
        label.add(recognizer)
        label.sizeToFit()
        label.isUserInteractionEnabled = true
        label.isSelectable = false
        label.isEditable = false
        label.isScrollEnabled = false
        label.backgroundColor = .clear
        label.attributedText = myString
        label.textAlignment = .left
        scrollView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                   constant: top).isActive = true
        label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка поля ввода электронной почты
    private func setupAddFileTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(addFileTextFieldPressed))
        let top = 40.f
        let width = Session.width - 110.f
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
        addFileTextField.topAnchor.constraint(equalTo: label.bottomAnchor,
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
        let width = 148.f
        let height = 44.f
        sendButton.layer.cornerRadius = height / 2
        sendButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        sendButton.update(isEnabled: true)
        sendButton.titleLabel?.font = .boldSystemFontOfSize(size: 12)
        sendButton.titleLabel?.numberOfLines = 2
        sendButton.titleLabel?.textAlignment = .center
        scrollView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        sendButtonWidth = sendButton.widthAnchor.constraint(equalToConstant: width)
        sendButtonWidth?.isActive = true
        sendButtonTop = sendButton.topAnchor.constraint(equalTo: addFileTextField.bottomAnchor,
                                                        constant: top)
        sendButtonTop?.isActive = true
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
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleAttachmentTap(_ sender: AttachmentTapGestureRecognizer) {
        let message = """
        Приложение HelpDoctor разработано специально для медицинских работников.\
        Кроме того, законодательство РФ запрещает обсуждение клинических тем\
        и рецептурных препаратов вне закрытых врачебных сообществ.
        """
        self.showInfo(message: message, buttonTitle: "Закрыть", iconName: nil)
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
extension VerificationViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentAt url: URL) {
        addFileTextField.text = url.lastPathComponent
        sourceFile = url
    }
    
}
