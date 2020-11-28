//
//  CreateProfileScreen2ViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 19.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileScreen2ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileScreen2PresenterProtocol?
    
    // MARK: - Constants and variables
    private let backgroundColor = UIColor.backgroundColor
    private var verticalInset = 0.f
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let heightTextField = 30.f
    private let heightTitleLabel = 20.f
    private let heightLabel = 15.f
    private let heightRadioButton = 20.f
    private let heightNextButton = 40.f
    private let scrollView = UIScrollView()
    private let birthDateDatePicker = UIDatePicker()
    private let step3TitleLabel = UILabel()
    private let step3Label = UILabel()
    private let hideBirthdayCheckbox = CheckBox(type: .square)
    private let step4TitleLabel = UILabel()
    private let step4Label = UITextView()
    private let phoneTextField = UITextField()
    private let hidePhoneCheckbox = CheckBox(type: .square)
    private let step5TitleLabel = UILabel()
    private let step5Label = UILabel()
    private let regionTextField = UITextField()
    private let cityTextField = UITextField()
    private let liveNotRussiaCheckbox = CheckBox(type: .square)
    private let nextButton = HDButton(title: "Далее")
    private var keyboardHeight = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        let contentHeight = headerHeight + (heightTitleLabel * 3) + (heightLabel * 3)
            + (heightTextField * 4) + (heightRadioButton * 3) + heightNextButton
        verticalInset = (Session.height - Session.statusBarHeight - contentHeight) / 14
        setupScrollView()
        setupStep3TitleLabel()
        setupStep3Label()
        setupBirthDateDatePicker()
        setupHideBirthdayCheckbox()
        setupStep4TitleLabel()
        setupStep4Label()
        setupPhoneTextField()
        setupHidePhoneCheckbox()
        setupStep5TitleLabel()
        setupStep5Label()
        setupRegionTextField()
        setupCityTextField()
        setupLiveNotRussiaCheckbox()
        setupNextButton()
        addTapGestureToHideKeyboard()
        setUser()
        guard let isEdit = presenter?.isEdit else { return }
        if isEdit {
            setupHeaderView(height: headerHeight, presenter: presenter)
            nextButton.setTitle("Готово", for: .normal)
        } else {
            setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Public methods
    /// Заполнение региона в поле ввода
    /// - Parameter region: регион
    func setRegion(region: String) {
        regionTextField.text = region
    }
    
    /// Заполнение города в поле воода
    /// - Parameter city: город
    func setCity(city: String) {
        cityTextField.text = city
    }
    
    // MARK: - Private methods
    private func setUser() {
        phoneTextField.text = Session.instance.user?.phoneNumber
        regionTextField.text = Session.instance.user?.regionName
        cityTextField.text = Session.instance.user?.cityName
        guard let regionId = Session.instance.user?.regionId else { return }
        presenter?.setRegionFromDevice(regionId)
        guard let birthday = Session.instance.user?.birthday else { return }
        birthDateDatePicker.setDate(birthday.toDate(withFormat: "yyyy-MM-dd") ?? Date(), animated: true)
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Session.width, height: Session.height - headerHeight)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    private func setupStep3TitleLabel() {
        step3TitleLabel.backgroundColor = .searchBarTintColor
        step3TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step3TitleLabel.textColor = .white
        step3TitleLabel.text = "Шаг 3"
        step3TitleLabel.textAlignment = .center
        scrollView.addSubview(step3TitleLabel)
        
        step3TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step3TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        step3TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step3TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом телефона
    private func setupStep3Label() {
        step3Label.font = .boldSystemFontOfSize(size: 14)
        step3Label.textColor = .white
        step3Label.text = "Укажите дату рождения"
        step3Label.textAlignment = .left
        scrollView.addSubview(step3Label)
        
        step3Label.translatesAutoresizingMaskIntoConstraints = false
        step3Label.topAnchor.constraint(equalTo: step3TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step3Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step3Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step3Label.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    /// Установка поля ввода даты рождения
    private func setupBirthDateDatePicker() {
        birthDateDatePicker.tintColor = .hdButtonColor
        birthDateDatePicker.locale = Locale(identifier: "ru_RU")
        birthDateDatePicker.datePickerMode = .date
        birthDateDatePicker.backgroundColor = .white
        birthDateDatePicker.layer.cornerRadius = 5
        scrollView.addSubview(birthDateDatePicker)
        
        birthDateDatePicker.translatesAutoresizingMaskIntoConstraints = false
        birthDateDatePicker.topAnchor.constraint(equalTo: step3Label.bottomAnchor,
                                                 constant: verticalInset).isActive = true
        birthDateDatePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        birthDateDatePicker.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        birthDateDatePicker.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка чекбокса скрытия даты рождения в профиле
    private func setupHideBirthdayCheckbox() {
        let leading = 0.f
        hideBirthdayCheckbox.contentHorizontalAlignment = .left
        hideBirthdayCheckbox.contentVerticalAlignment = .center
        hideBirthdayCheckbox.setTitle(" Не показывать другим", for: .normal)
        hideBirthdayCheckbox.titleLabel?.font = .systemFontOfSize(size: 12)
        hideBirthdayCheckbox.setTitleColor(.white, for: .normal)
        hideBirthdayCheckbox.addTarget(self, action: #selector(hideBirthdayCheckboxPressed), for: .touchUpInside)
        scrollView.addSubview(hideBirthdayCheckbox)
        
        hideBirthdayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        hideBirthdayCheckbox.topAnchor.constraint(equalTo: birthDateDatePicker.bottomAnchor,
                                                  constant: verticalInset).isActive = true
        hideBirthdayCheckbox.leadingAnchor.constraint(equalTo: birthDateDatePicker.leadingAnchor,
                                                      constant: leading).isActive = true
        hideBirthdayCheckbox.trailingAnchor.constraint(equalTo: birthDateDatePicker.trailingAnchor,
                                                       constant: -leading).isActive = true
        hideBirthdayCheckbox.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка заголовка Шаг 4
    private func setupStep4TitleLabel() {
        step4TitleLabel.backgroundColor = .searchBarTintColor
        step4TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step4TitleLabel.textColor = .white
        step4TitleLabel.text = "Шаг 4"
        step4TitleLabel.textAlignment = .center
        scrollView.addSubview(step4TitleLabel)
        
        step4TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step4TitleLabel.topAnchor.constraint(equalTo: hideBirthdayCheckbox.bottomAnchor,
                                             constant: verticalInset).isActive = true
        step4TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step4TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед заполнением данных шага 4
    private func setupStep4Label() {
        guard let iconImage = UIImage(named: "Info") else { return }
        let font = UIFont.boldSystemFontOfSize(size: 14)
        let attachment = NSTextAttachment()
        attachment.bounds = CGRect(x: 0,
                                   y: (font.capHeight - iconImage.size.height).rounded() / 2,
                                   width: iconImage.size.width,
                                   height: iconImage.size.height)
        attachment.image = iconImage
        let attachmentString = NSAttributedString(attachment: attachment)
        let text = "Укажите номер телефона "
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        let myString = NSMutableAttributedString(string: text, attributes: attributes)
        myString.append(attachmentString)
        let recognizer = AttachmentTapGestureRecognizer(target: self, action: #selector(handleAttachmentTap(_:)))
        step4Label.add(recognizer)
        step4Label.sizeToFit()
        step4Label.isUserInteractionEnabled = true
        step4Label.isSelectable = false
        step4Label.isEditable = false
        step4Label.isScrollEnabled = false
        step4Label.backgroundColor = .clear
        step4Label.attributedText = myString
        step4Label.textAlignment = .left
        scrollView.addSubview(step4Label)
        
        step4Label.translatesAutoresizingMaskIntoConstraints = false
        step4Label.topAnchor.constraint(equalTo: step4TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step4Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step4Label.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка поля ввода телефона
    private func setupPhoneTextField() {
        phoneTextField.delegate = self
        phoneTextField.font = UIFont.systemFontOfSize(size: 14)
        phoneTextField.textColor = .textFieldTextColor
        phoneTextField.keyboardType = .numberPad
        phoneTextField.placeholder = "+7 (xxx) xxx-xx-xx*"
        phoneTextField.textAlignment = .left
        phoneTextField.backgroundColor = .white
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.leftView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: 8,
                                                       height: phoneTextField.frame.height))
        phoneTextField.leftViewMode = .always
        scrollView.addSubview(phoneTextField)
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.topAnchor.constraint(equalTo: step4Label.bottomAnchor,
                                            constant: verticalInset).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupHidePhoneCheckbox() {
        let leading = 0.f
        hidePhoneCheckbox.contentHorizontalAlignment = .left
        hidePhoneCheckbox.contentVerticalAlignment = .center
        hidePhoneCheckbox.setTitle(" Не показывать другим", for: .normal)
        hidePhoneCheckbox.titleLabel?.font = .systemFontOfSize(size: 12)
        hidePhoneCheckbox.setTitleColor(.white, for: .normal)
        hidePhoneCheckbox.addTarget(self, action: #selector(hidePhoneCheckboxPressed), for: .touchUpInside)
        scrollView.addSubview(hidePhoneCheckbox)
        
        hidePhoneCheckbox.translatesAutoresizingMaskIntoConstraints = false
        hidePhoneCheckbox.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor,
                                               constant: verticalInset).isActive = true
        hidePhoneCheckbox.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor,
                                                   constant: leading).isActive = true
        hidePhoneCheckbox.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor,
                                                    constant: -leading).isActive = true
        hidePhoneCheckbox.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка заголовка Шаг 5
    private func setupStep5TitleLabel() {
        step5TitleLabel.backgroundColor = .searchBarTintColor
        step5TitleLabel.font = .boldSystemFontOfSize(size: 14)
        step5TitleLabel.textColor = .white
        step5TitleLabel.text = "Шаг 5"
        step5TitleLabel.textAlignment = .center
        scrollView.addSubview(step5TitleLabel)
        
        step5TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TitleLabel.topAnchor.constraint(equalTo: hidePhoneCheckbox.bottomAnchor,
                                             constant: verticalInset).isActive = true
        step5TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step5TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка поясняющей надписи перед вводом даты рождения
    private func setupStep5Label() {
        step5Label.font = .boldSystemFontOfSize(size: 14)
        step5Label.textColor = .white
        step5Label.text = "Укажите свое место жительства"
        step5Label.textAlignment = .left
        scrollView.addSubview(step5Label)
        
        step5Label.translatesAutoresizingMaskIntoConstraints = false
        step5Label.topAnchor.constraint(equalTo: step5TitleLabel.bottomAnchor,
                                        constant: verticalInset).isActive = true
        step5Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5Label.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step5Label.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    /// Установка поля ввода региона места жительства
    private func setupRegionTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(regionSearchButtonPressed))
        regionTextField.font = .systemFontOfSize(size: 14)
        regionTextField.textColor = .textFieldTextColor
        regionTextField.textAlignment = .left
        regionTextField.backgroundColor = .white
        regionTextField.layer.cornerRadius = 5
        regionTextField.leftView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 8,
                                                        height: regionTextField.frame.height))
        regionTextField.leftViewMode = .always
        regionTextField.placeholder = "Субъект РФ*"
        regionTextField.addGestureRecognizer(tap)
        scrollView.addSubview(regionTextField)
        
        regionTextField.translatesAutoresizingMaskIntoConstraints = false
        regionTextField.topAnchor.constraint(equalTo: step5Label.bottomAnchor,
                                             constant: verticalInset).isActive = true
        regionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        regionTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        regionTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка поля ввода города места жительства
    private func setupCityTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(citySearchButtonPressed))
        cityTextField.font = .systemFontOfSize(size: 14)
        cityTextField.textColor = .textFieldTextColor
        cityTextField.textAlignment = .left
        cityTextField.backgroundColor = .white
        cityTextField.layer.cornerRadius = 5
        cityTextField.leftView = setupDefaultLeftView()
        cityTextField.leftViewMode = .always
        cityTextField.placeholder = "Город / район*"
        cityTextField.addGestureRecognizer(tap)
        scrollView.addSubview(cityTextField)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: regionTextField.bottomAnchor,
                                           constant: verticalInset).isActive = true
        cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cityTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    private func setupLiveNotRussiaCheckbox() {
        let leading = 0.f
        liveNotRussiaCheckbox.contentHorizontalAlignment = .left
        liveNotRussiaCheckbox.contentVerticalAlignment = .center
        liveNotRussiaCheckbox.setTitle(" Проживаю не в России", for: .normal)
        liveNotRussiaCheckbox.titleLabel?.font = .systemFontOfSize(size: 12)
        liveNotRussiaCheckbox.setTitleColor(.white, for: .normal)
        liveNotRussiaCheckbox.addTarget(self, action: #selector(liveNotRussiaCheckboxPressed), for: .touchUpInside)
        scrollView.addSubview(liveNotRussiaCheckbox)
        
        liveNotRussiaCheckbox.translatesAutoresizingMaskIntoConstraints = false
        liveNotRussiaCheckbox.topAnchor.constraint(equalTo: cityTextField.bottomAnchor,
                                                   constant: verticalInset).isActive = true
        liveNotRussiaCheckbox.leadingAnchor.constraint(equalTo: cityTextField.leadingAnchor,
                                                       constant: leading).isActive = true
        liveNotRussiaCheckbox.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor,
                                                        constant: -leading).isActive = true
        liveNotRussiaCheckbox.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 110.f
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 20).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: Session.height - Session.bottomPadding - 98).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: heightNextButton).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
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
        view.viewWithTag(Session.tagSavedView)?.removeFromSuperview()
        view.viewWithTag(Session.tagAlertView)?.removeFromSuperview()
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
    /// Действие при нажатии на чекбокс скрытия даты рождения
    @objc private func hideBirthdayCheckboxPressed() {
        hideBirthdayCheckbox.isSelected = !hideBirthdayCheckbox.isSelected
    }
    
    @objc func handleAttachmentTap(_ sender: AttachmentTapGestureRecognizer) {
        let message = """
        Номер телефона необходим для однозначной идентификации пользователей и в случае утери доступа к профилю
        """
        self.showInfo(message: message, buttonTitle: "Понятно", iconName: "InfoHeadIcon")
    }
    
    @objc private func hidePhoneCheckboxPressed() {
        hidePhoneCheckbox.isSelected = !hidePhoneCheckbox.isSelected
    }
    
    @objc private func liveNotRussiaCheckboxPressed() {
        liveNotRussiaCheckbox.isSelected = !liveNotRussiaCheckbox.isSelected
        regionTextField.alpha = liveNotRussiaCheckbox.isSelected ? 0.5 : 1.0
        cityTextField.alpha = liveNotRussiaCheckbox.isSelected ? 0.5 : 1.0
        regionTextField.isEnabled = !liveNotRussiaCheckbox.isSelected
        cityTextField.isEnabled = !liveNotRussiaCheckbox.isSelected
        regionTextField.text = ""
        cityTextField.text = ""
        presenter?.setLiveInNotRussia()
    }
    
    @objc private func regionSearchButtonPressed() {
        presenter?.regionSearch()
    }
    
    @objc private func citySearchButtonPressed() {
        presenter?.citySearch()
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        guard let phone = phoneTextField.text else { return }
        let birthdate = birthDateDatePicker.date.toString(withFormat: "dd.MM.yyyy")
        presenter?.next(phone: phone, birthdate: birthdate)
    }
}
//swiftlint:disable force_unwrapping
extension CreateProfileScreen2ViewController: UITextFieldDelegate {
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
        
        if textField == phoneTextField {
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
