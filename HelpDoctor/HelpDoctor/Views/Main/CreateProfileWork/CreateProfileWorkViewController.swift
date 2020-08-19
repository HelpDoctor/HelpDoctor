//
//  CreateProfileWorkViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 01.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class CreateProfileWorkViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependency
    var presenter: CreateProfileWorkPresenterProtocol?
    
    // MARK: - Constants
    private let backgroundColor = UIColor.backgroundColor
    private var verticalInset = 0.f
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let heightTextField = 30.f
    private let heightTitleLabel = 20.f
    private let heightLabel = 15.f
    private let heightTableView = 70.f
    private let heightRadioButton = 20.f
    private let heightPlusButton = 25.f
    private let heightNextButton = 40.f
    private let scrollView = UIScrollView()
    private let step7TitleLabel = UILabel()
    private let step7JobLabel = UILabel()
    private let jobTableView = UITableView()
    private let workPlusButton = PlusButton(type: .square)
    private let workPlusLabel = UILabel()
    private let step7SpecLabel = UILabel()
    private let specTableView = UITableView()
    private let specPlusButton = PlusButton(type: .square)
    private let specPlusLabel = UILabel()
    private let positionTextField = UITextField()
    private let employmentLabel = UILabel()
    private let medicalButton = RadioButton()
    private let medicalButtonLabel = UILabel()
    private let notMedicalButton = RadioButton()
    private let notMedicalButtonLabel = UILabel()
    private let hideEmploymentButton = CheckBox(type: .square)
    private let nextButton = HDButton(title: "Далее")
    private var employmentLabelTop: NSLayoutConstraint?
    private var positionTextFieldTop: NSLayoutConstraint?
    private var jobTableViewHeight: NSLayoutConstraint?
    private var specTableViewHeight: NSLayoutConstraint?
    private var nextButtonTopAnchor: NSLayoutConstraint?
    private var jobRowCount = 2
    private var specRowCount = 2
    private var heightScroll = Session.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = backgroundColor
        let contentHeight = headerHeight + heightTitleLabel + (heightLabel * 3) + (heightTableView * 2)
            + heightTextField + (heightRadioButton * 2) + (heightPlusButton * 2) + heightNextButton
        verticalInset = (Session.height - UIApplication.shared.statusBarFrame.height - contentHeight) / 12
        setupScrollView()
        setupStep7TitleLabel()
        setupStep7SpecLabel()
        setupSpecTableView()
        setupSpecPlusButton()
        setupSpecPlusLabel()
        setupEmploymentLabel()
        setupMedicalButton()
        setupMedicalButtonLabel()
        setupNotMedicalButton()
        setupNotMedicalButtonLabel()
        setupStep7JobLabel()
        setupJobTableView()
        setupWorkPlusButton()
        setupWorkPlusLabel()
        setupPositionTextField()
        setupHideEmploymentButton()
        setupNextButton()
        addSwipeGestureToBack()
        configureRadioButtons()
        disableJobArea(isMedical: false)
        guard let isEdit = presenter?.isEdit else { return }
        if isEdit {
            setupHeaderView(height: headerHeight, presenter: presenter)
            nextButton.setTitle("Готово", for: .normal)
            presenter?.setUser()
        } else {
            setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .clear)
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    // MARK: - Public methods
    func reloadJobTableView() {
        jobTableView.reloadData()
    }
    
    func reloadSpecTableView() {
        specTableView.reloadData()
    }
    
    func setEmployment(isMedic: Bool) {
        if isMedic {
            medicalButton.isSelected = true
        } else {
            notMedicalButton.isSelected = true
        }
        employmentButtonPressed()
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
    private func setupScrollView() {
        scrollView.delegate = self
        heightScroll = headerHeight
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: headerHeight).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: Session.height).isActive = true
    }
    
    /// Установка надписи
    private func setupStep7TitleLabel() {
        heightScroll += heightTitleLabel
        step7TitleLabel.backgroundColor = .searchBarTintColor
        step7TitleLabel.font = UIFont.boldSystemFontOfSize(size: 14)
        step7TitleLabel.textColor = .white
        step7TitleLabel.text = "Шаг 7"
        step7TitleLabel.textAlignment = .center
        scrollView.addSubview(step7TitleLabel)
        
        step7TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step7TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        step7TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step7TitleLabel.heightAnchor.constraint(equalToConstant: heightTitleLabel).isActive = true
    }
    
    /// Установка надписи указания медицинской специализации
    private func setupStep7SpecLabel() {
        heightScroll += verticalInset + heightLabel
        step7SpecLabel.font = .boldSystemFontOfSize(size: 14)
        step7SpecLabel.textColor = .white
        step7SpecLabel.text = "Укажите медицинскую специализацию"
        step7SpecLabel.textAlignment = .left
        scrollView.addSubview(step7SpecLabel)
        
        step7SpecLabel.translatesAutoresizingMaskIntoConstraints = false
        step7SpecLabel.topAnchor.constraint(equalTo: step7TitleLabel.bottomAnchor,
                                            constant: verticalInset).isActive = true
        step7SpecLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7SpecLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step7SpecLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupSpecTableView() {
        heightScroll += verticalInset + heightTableView
        scrollView.addSubview(specTableView)
        specTableView.register(JobCell.self, forCellReuseIdentifier: "JobCell")
        specTableView.backgroundColor = .clear
        specTableView.dataSource = self
        specTableView.delegate = self
        specTableView.separatorStyle = .none
        specTableView.showsVerticalScrollIndicator = false
        specTableView.isScrollEnabled = false
        
        specTableView.translatesAutoresizingMaskIntoConstraints = false
        specTableView.topAnchor.constraint(equalTo: step7SpecLabel.bottomAnchor,
                                           constant: verticalInset).isActive = true
        specTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        specTableView.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        specTableViewHeight = specTableView.heightAnchor.constraint(equalToConstant: heightTableView)
        specTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления медицинской специализации
    private func setupSpecPlusButton() {
        let leading = 20.f
        heightScroll += verticalInset + heightPlusButton
        specPlusButton.addTarget(self, action: #selector(specPlusButtonPressed), for: .touchUpInside)
        view.addSubview(specPlusButton)
        
        specPlusButton.translatesAutoresizingMaskIntoConstraints = false
        specPlusButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                            constant: verticalInset).isActive = true
        specPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        specPlusButton.widthAnchor.constraint(equalToConstant: heightPlusButton).isActive = true
        specPlusButton.heightAnchor.constraint(equalToConstant: heightPlusButton).isActive = true
    }
    
    /// Установка поясняющей надписи у кнопки добавления специализации
    private func setupSpecPlusLabel() {
        let leading = 10.f
        specPlusLabel.font = .systemFontOfSize(size: 14)
        specPlusLabel.textColor = .white
        specPlusLabel.text = "Добавить специализацию"
        specPlusLabel.textAlignment = .left
        scrollView.addSubview(specPlusLabel)
        
        specPlusLabel.translatesAutoresizingMaskIntoConstraints = false
        specPlusLabel.topAnchor.constraint(equalTo: specPlusButton.topAnchor).isActive = true
        specPlusLabel.leadingAnchor.constraint(equalTo: specPlusButton.trailingAnchor,
                                               constant: leading).isActive = true
        specPlusLabel.trailingAnchor.constraint(equalTo: specTableView.trailingAnchor).isActive = true
        specPlusLabel.heightAnchor.constraint(equalTo: specPlusButton.heightAnchor).isActive = true
    }
    
    /// Установка надписи занятость
    private func setupEmploymentLabel() {
        heightScroll += verticalInset + heightLabel
        employmentLabel.font = .boldSystemFontOfSize(size: 14)
        employmentLabel.textColor = .white
        employmentLabel.text = "Занятость"
        employmentLabel.textAlignment = .left
        scrollView.addSubview(employmentLabel)
        
        employmentLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        employmentLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        employmentLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
        employmentLabelTop = employmentLabel.topAnchor.constraint(equalTo: specPlusButton.bottomAnchor,
                                                                  constant: verticalInset)
        employmentLabelTop?.isActive = true
    }
    
    /// Установка радиокнопки выбора работы медицинским работником
    private func setupMedicalButton() {
        let leading = 20.f
        heightScroll += verticalInset + heightRadioButton
        medicalButton.contentHorizontalAlignment = .left
        medicalButton.isSelected = false
        medicalButton.addTarget(self, action: #selector(employmentButtonPressed), for: .touchUpInside)
        scrollView.addSubview(medicalButton)
        
        medicalButton.translatesAutoresizingMaskIntoConstraints = false
        medicalButton.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor,
                                           constant: verticalInset).isActive = true
        medicalButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: leading).isActive = true
        medicalButton.widthAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
        medicalButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    private func setupMedicalButtonLabel() {
        let leading = 10.f
        let width = (Session.width / 2) - leading - 40
        medicalButtonLabel.font = .systemFontOfSize(size: 12)
        medicalButtonLabel.textColor = .white
        medicalButtonLabel.text = "Я работаю в сфере медицины"
        medicalButtonLabel.textAlignment = .left
        medicalButtonLabel.numberOfLines = 2
        scrollView.addSubview(medicalButtonLabel)
        
        medicalButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        medicalButtonLabel.centerYAnchor.constraint(equalTo: medicalButton.centerYAnchor).isActive = true
        medicalButtonLabel.leadingAnchor.constraint(equalTo: medicalButton.trailingAnchor,
                                                    constant: leading).isActive = true
        medicalButtonLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка радиокнопки выбора работы не медицинским работником
    private func setupNotMedicalButton() {
        let leading = Session.width / 2
        notMedicalButton.contentHorizontalAlignment = .left
        notMedicalButton.isSelected = false
        notMedicalButton.addTarget(self, action: #selector(employmentButtonPressed), for: .touchUpInside)
        scrollView.addSubview(notMedicalButton)
        
        notMedicalButton.translatesAutoresizingMaskIntoConstraints = false
        notMedicalButton.topAnchor.constraint(equalTo: medicalButton.topAnchor).isActive = true
        notMedicalButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                  constant: leading).isActive = true
        notMedicalButton.widthAnchor.constraint(equalTo: medicalButton.widthAnchor,
                                                multiplier: 1).isActive = true
        notMedicalButton.heightAnchor.constraint(equalTo: medicalButton.heightAnchor,
                                                 multiplier: 1).isActive = true
    }
    
    private func setupNotMedicalButtonLabel() {
        let leading = 10.f
        let width = (Session.width / 2) - leading - 40
        notMedicalButtonLabel.font = .systemFontOfSize(size: 12)
        notMedicalButtonLabel.textColor = .white
        notMedicalButtonLabel.text = "Я не работаю в сфере медицины"
        notMedicalButtonLabel.textAlignment = .left
        notMedicalButtonLabel.numberOfLines = 2
        scrollView.addSubview(notMedicalButtonLabel)
        
        notMedicalButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        notMedicalButtonLabel.centerYAnchor.constraint(equalTo: notMedicalButton.centerYAnchor).isActive = true
        notMedicalButtonLabel.leadingAnchor.constraint(equalTo: notMedicalButton.trailingAnchor,
                                                       constant: leading).isActive = true
        notMedicalButtonLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка надписи указания места жительства
    private func setupStep7JobLabel() {
        heightScroll += verticalInset + heightLabel
        step7JobLabel.numberOfLines = 0
        step7JobLabel.font = .boldSystemFontOfSize(size: 14)
        step7JobLabel.textColor = .white
        step7JobLabel.text = "Укажите место работы"
        step7JobLabel.textAlignment = .left
        scrollView.addSubview(step7JobLabel)
        
        step7JobLabel.translatesAutoresizingMaskIntoConstraints = false
        step7JobLabel.topAnchor.constraint(equalTo: medicalButton.bottomAnchor,
                                           constant: verticalInset).isActive = true
        step7JobLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7JobLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step7JobLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    /// Установка таблицы с местами работы
    private func setupJobTableView() {
        heightScroll += verticalInset + heightTableView
        scrollView.addSubview(jobTableView)
        jobTableView.register(JobCell.self, forCellReuseIdentifier: "JobCell")
        jobTableView.backgroundColor = .clear
        jobTableView.dataSource = self
        jobTableView.delegate = self
        jobTableView.separatorStyle = .none
        jobTableView.showsVerticalScrollIndicator = false
        jobTableView.isScrollEnabled = false
        
        jobTableView.translatesAutoresizingMaskIntoConstraints = false
        jobTableView.topAnchor.constraint(equalTo: step7JobLabel.bottomAnchor,
                                          constant: verticalInset).isActive = true
        jobTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        jobTableView.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        jobTableViewHeight = jobTableView.heightAnchor.constraint(equalToConstant: heightTableView)
        jobTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления места работы
    private func setupWorkPlusButton() {
        let leading = 20.f
        heightScroll += verticalInset + heightPlusButton
        workPlusButton.addTarget(self, action: #selector(workPlusButtonPressed), for: .touchUpInside)
        view.addSubview(workPlusButton)
        
        workPlusButton.translatesAutoresizingMaskIntoConstraints = false
        workPlusButton.topAnchor.constraint(equalTo: jobTableView.bottomAnchor,
                                            constant: verticalInset).isActive = true
        workPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        workPlusButton.widthAnchor.constraint(equalToConstant: heightPlusButton).isActive = true
        workPlusButton.heightAnchor.constraint(equalToConstant: heightPlusButton).isActive = true
    }
    
    /// Установка поясняющей надписи у кнопки добавления места работы
    private func setupWorkPlusLabel() {
        let leading = 10.f
        workPlusLabel.font = .systemFontOfSize(size: 14)
        workPlusLabel.textColor = .white
        workPlusLabel.text = "Добавить место работы"
        workPlusLabel.textAlignment = .left
        scrollView.addSubview(workPlusLabel)
        
        workPlusLabel.translatesAutoresizingMaskIntoConstraints = false
        workPlusLabel.topAnchor.constraint(equalTo: workPlusButton.topAnchor).isActive = true
        workPlusLabel.leadingAnchor.constraint(equalTo: workPlusButton.trailingAnchor,
                                               constant: leading).isActive = true
        workPlusLabel.trailingAnchor.constraint(equalTo: jobTableView.trailingAnchor).isActive = true
        workPlusLabel.heightAnchor.constraint(equalTo: workPlusButton.heightAnchor).isActive = true
    }
    
    /// Установка поля ввода должности
    private func setupPositionTextField() {
        heightScroll += verticalInset + heightTextField
        positionTextField.font = UIFont.systemFontOfSize(size: 14)
        positionTextField.textColor = .textFieldTextColor
        positionTextField.placeholder = "Должность"
        positionTextField.textAlignment = .left
        positionTextField.backgroundColor = .white
        positionTextField.layer.cornerRadius = 5
        positionTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 8,
                                                          height: positionTextField.frame.height))
        positionTextField.leftViewMode = .always
        scrollView.addSubview(positionTextField)
        
        positionTextField.translatesAutoresizingMaskIntoConstraints = false
        //        positionTextField.topAnchor.constraint(equalTo: workPlusButton.bottomAnchor,
        //                                               constant: verticalInset).isActive = true
        positionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        positionTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        positionTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
        positionTextFieldTop = positionTextField.topAnchor.constraint(equalTo: workPlusButton.bottomAnchor,
                                                                      constant: verticalInset)
        positionTextFieldTop?.isActive = true
    }
    
    /// Установка радиокнопки скрытия информации о занятости
    private func setupHideEmploymentButton() {
        heightScroll += verticalInset + heightRadioButton
        hideEmploymentButton.addTarget(self, action: #selector(hideEmploymentCheckboxPressed), for: .touchUpInside)
        hideEmploymentButton.contentHorizontalAlignment = .left
        hideEmploymentButton.contentVerticalAlignment = .center
        hideEmploymentButton.setTitle(" Скрыть информацию о моей занятости в результатах поиска", for: .normal)
        hideEmploymentButton.titleLabel?.font = .systemFontOfSize(size: 12)
        hideEmploymentButton.setTitleColor(.white, for: .normal)
        hideEmploymentButton.isSelected = false
        scrollView.addSubview(hideEmploymentButton)
        
        hideEmploymentButton.translatesAutoresizingMaskIntoConstraints = false
        hideEmploymentButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor,
                                                  constant: verticalInset).isActive = true
        hideEmploymentButton.leadingAnchor.constraint(equalTo: medicalButton.leadingAnchor).isActive = true
        hideEmploymentButton.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        hideEmploymentButton.heightAnchor.constraint(equalToConstant: heightRadioButton).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let width = 110.f
        heightScroll += verticalInset + heightNextButton + 34
        let bottom = heightScroll < Session.height ? Session.height : heightScroll
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: heightNextButton).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        nextButtonTopAnchor = nextButton.bottomAnchor.constraint(equalTo: scrollView.topAnchor,
                                                                 constant: bottom - Session.bottomPadding - 98)
        nextButtonTopAnchor?.isActive = true
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    /// Настройка выбора радиокнопки
    private func configureRadioButtons() {
        medicalButton.alternateButton = [notMedicalButton]
        notMedicalButton.alternateButton = [medicalButton]
    }
    
    // MARK: - IBActions
    private func disableJobArea(isMedical: Bool) {
        let alpha: CGFloat = isMedical ? 1.0 : 0.5
        step7JobLabel.alpha = alpha
        jobTableView.alpha = alpha
        workPlusButton.alpha = alpha
        workPlusLabel.alpha = alpha
        positionTextField.alpha = alpha
        hideEmploymentButton.alpha = alpha
        step7JobLabel.isEnabled = isMedical
        jobTableView.isUserInteractionEnabled = isMedical
        workPlusButton.isEnabled = isMedical
        workPlusLabel.isEnabled = isMedical
        positionTextField.isEnabled = isMedical
        hideEmploymentButton.isEnabled = isMedical
    }
    
    // MARK: - Buttons methods 
    @objc private func workPlusButtonPressed() {
        heightScroll += 35
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        jobTableViewHeight?.isActive = false
        jobTableViewHeight?.constant += 35
        jobTableViewHeight?.isActive = true
        if heightScroll > Session.height {
            nextButtonTopAnchor?.isActive = false
            nextButtonTopAnchor?.constant += 35
            nextButtonTopAnchor?.isActive = true
        }
        jobRowCount += 1
        jobTableView.reloadData()
        if jobRowCount > 4 {
            workPlusButton.isHidden = true
            workPlusLabel.isHidden = true
            positionTextFieldTop?.isActive = false
            positionTextFieldTop = positionTextField.topAnchor.constraint(equalTo: jobTableView.bottomAnchor,
                                                                          constant: verticalInset)
            positionTextFieldTop?.isActive = true
        }
    }
    
    @objc private func specPlusButtonPressed() {
        heightScroll += 35
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        specTableViewHeight?.isActive = false
        specTableViewHeight?.constant += 35
        specTableViewHeight?.isActive = true
        if heightScroll > Session.height {
            nextButtonTopAnchor?.isActive = false
            nextButtonTopAnchor?.constant += 35
            nextButtonTopAnchor?.isActive = true
        }
        specRowCount += 1
        specTableView.reloadData()
        if specRowCount > 4 {
            specPlusButton.isHidden = true
            specPlusLabel.isHidden = true
            employmentLabelTop?.isActive = false
            employmentLabelTop = employmentLabel.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                                      constant: verticalInset)
            employmentLabelTop?.isActive = true
        }
    }
    
    @objc private func employmentButtonPressed() {
        if medicalButton.isSelected {
            presenter?.setEmployment(true)
        } else {
            presenter?.setEmployment(false)
        }
        disableJobArea(isMedical: medicalButton.isSelected)
        if jobRowCount > 4 {
            workPlusButton.isHidden = true
            workPlusLabel.isHidden = true
        }
    }
    
    @objc private func hideEmploymentCheckboxPressed() {
        hideEmploymentButton.isSelected = !hideEmploymentButton.isSelected
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        if !medicalButton.isSelected && !notMedicalButton.isSelected {
            showAlert(message: "Поле занятость не заполнено")
        } else {
            presenter?.next()
        }
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}

// MARK: - Table view
extension CreateProfileWorkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTextField + 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.jobTableView {
            presenter?.jobSearch(indexPath.row)
        } else {
            presenter?.specSearch(indexPath.row)
        }
        
    }
    
}

extension CreateProfileWorkViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.jobTableView {
            if presenter?.getCountJob() ?? 0 < jobRowCount {
                return jobRowCount
            } else {
                return presenter?.getCountJob() ?? jobRowCount
            }
        } else {
            if presenter?.getCountSpec() ?? 0 < specRowCount {
                return specRowCount
            } else {
                return presenter?.getCountSpec() ?? specRowCount
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell",
                                                       for: indexPath) as? JobCell
            else { return UITableViewCell() }
        
        if tableView == self.jobTableView {
            let job = presenter?.getJob(indexPath.row) ?? "Место работы"
            var value = NSAttributedString(string: "")
            if job == "" {
                switch indexPath.row {
                case 0:
                    value = NSAttributedString(string: "Основное место работы*")
                default:
                    value = NSAttributedString(string: "Дополнительное место работы")
                }
                cell.configure(value)
            } else {
                cell.configure(job)
            }
        } else {
            let spec = presenter?.getSpec(indexPath.row) ?? "Специализация"
            var value = NSAttributedString(string: "")
            if spec == "" {
                switch indexPath.row {
                case 0:
                    value = NSAttributedString(string: "Основная специализация*")
                default:
                    value = NSAttributedString(string: "Дополнительная специализация")
                }
                cell.configure(value)
            } else {
                cell.configure(spec)
            }
        }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
        
    }
    
}
