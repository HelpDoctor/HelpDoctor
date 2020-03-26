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
    private let headerHeight = 60.f
    private let textFieldWidth = Session.width - 40
    private let textFieldHeight = 30.f
    private let scrollView = UIScrollView()
    private let step7TitleLabel = UILabel()
    private let step7JobLabel = UILabel()
    private let jobTableView = UITableView()
    private let workPlusButton = PlusButton()
    private let step7SpecLabel = UILabel()
    private let specTableView = UITableView()
    private let specPlusButton = PlusButton()
    private let positionTextField = UITextField()
    private let employmentLabel = UILabel()
    private let medicalButton = RadioButton()
    private let notMedicalButton = RadioButton()
    private let hideEmploymentButton = RadioButton()
    private let nextButton = HDButton(title: "Далее")
    private var jobTableViewHeight: NSLayoutConstraint?
    private var specTableViewHeight: NSLayoutConstraint?
    private var jobRowCount = 2
    private var specRowCount = 2
    private var heightScroll = Session.height
    private let window = UIApplication.shared.keyWindow
    private var bottomPadding = 0.f
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = backgroundColor
        bottomPadding = window?.safeAreaInsets.bottom ?? 0
        setupScrollView()
        setupHeaderView(color: backgroundColor, height: headerHeight, presenter: presenter)
        setupStep7TitleLabel()
        setupStep7JobLabel()
        setupJobTableView()
        setupWorkPlusButton()
        setupStep7SpecLabel()
        setupSpecTableView()
        setupSpecPlusButton()
        setupPositionTextField()
        setupEmploymentLabel()
        setupMedicalButton()
        setupNotMedicalButton()
        setupHideEmploymentButton()
        setupNextButton()
        addSwipeGestureToBack()
        configureRadioButtons()
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
        let height = 20.f
        heightScroll += height
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
        step7TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи указания места жительства
    private func setupStep7JobLabel() {
        let top = 5.f
        let height = 34.f
        heightScroll += top + height
        step7JobLabel.numberOfLines = 0
        step7JobLabel.font = UIFont.systemFontOfSize(size: 14)
        step7JobLabel.textColor = .white
        step7JobLabel.text = "Заполните данные о своей профессиональной деятельности"
        step7JobLabel.textAlignment = .left
        scrollView.addSubview(step7JobLabel)
        
        step7JobLabel.translatesAutoresizingMaskIntoConstraints = false
        step7JobLabel.topAnchor.constraint(equalTo: step7TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step7JobLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7JobLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step7JobLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка таблицы с местами работы
    private func setupJobTableView() {
        let top = 5.f
        let height = 70.f
        heightScroll += top + height
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
                                          constant: top).isActive = true
        jobTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        jobTableView.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        jobTableViewHeight = jobTableView.heightAnchor.constraint(equalToConstant: height)
        jobTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления места работы
    private func setupWorkPlusButton() {
        let leading = 30.f
        let top = 5.f
        let height = 20.f
        workPlusButton.addTarget(self, action: #selector(workPlusButtonPressed), for: .touchUpInside)
        view.addSubview(workPlusButton)
        
        workPlusButton.translatesAutoresizingMaskIntoConstraints = false
        workPlusButton.topAnchor.constraint(equalTo: jobTableView.bottomAnchor,
                                            constant: top).isActive = true
        workPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        workPlusButton.widthAnchor.constraint(equalToConstant: height).isActive = true
        workPlusButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи указания медицинской специализации
    private func setupStep7SpecLabel() {
        let top = 40.f
        let height = 15.f
        heightScroll += top + height
        step7SpecLabel.font = UIFont.systemFontOfSize(size: 14)
        step7SpecLabel.textColor = .white
        step7SpecLabel.text = "Укажите медицинскую специализацию"
        step7SpecLabel.textAlignment = .left
        scrollView.addSubview(step7SpecLabel)
        
        step7SpecLabel.translatesAutoresizingMaskIntoConstraints = false
        step7SpecLabel.topAnchor.constraint(equalTo: jobTableView.bottomAnchor,
                                              constant: top).isActive = true
        step7SpecLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step7SpecLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        step7SpecLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSpecTableView() {
        let top = 5.f
        let height = 70.f
        heightScroll += top + height
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
                                          constant: top).isActive = true
        specTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        specTableView.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        specTableViewHeight = specTableView.heightAnchor.constraint(equalToConstant: height)
        specTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления медицинской специализации
    private func setupSpecPlusButton() {
        let leading = 30.f
        let top = 5.f
        let height = 20.f
        specPlusButton.addTarget(self, action: #selector(specPlusButtonPressed), for: .touchUpInside)
        view.addSubview(specPlusButton)
        
        specPlusButton.translatesAutoresizingMaskIntoConstraints = false
        specPlusButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                            constant: top).isActive = true
        specPlusButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        specPlusButton.widthAnchor.constraint(equalToConstant: height).isActive = true
        specPlusButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода должности
    private func setupPositionTextField() {
        let top = 40.f
        heightScroll += top + textFieldHeight
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
        positionTextField.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                               constant: top).isActive = true
        positionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        positionTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        positionTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    /// Установка надписи занятость
    private func setupEmploymentLabel() {
        let top = 5.f
        let height = 15.f
        employmentLabel.font = UIFont.systemFontOfSize(size: 14)
        employmentLabel.textColor = .white
        employmentLabel.text = "Занятость"
        employmentLabel.textAlignment = .left
        scrollView.addSubview(employmentLabel)
        
        employmentLabel.translatesAutoresizingMaskIntoConstraints = false
        employmentLabel.topAnchor.constraint(equalTo: positionTextField.bottomAnchor,
                                             constant: top).isActive = true
        employmentLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        employmentLabel.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        employmentLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора работы медицинским работником
    private func setupMedicalButton() {
        let top = 9.f
        let leading = 10.f
        let width = Session.width - (leading * 2)
        let height = 15.f
        medicalButton.contentHorizontalAlignment = .left
        medicalButton.setTitle(" Я работаю как медицинский работник", for: .normal)
        medicalButton.titleLabel?.font = .systemFontOfSize(size: 12)
        medicalButton.setTitleColor(.white, for: .normal)
        medicalButton.isSelected = false
        medicalButton.addTarget(self, action: #selector(employmentButtonPressed), for: .touchUpInside)
        scrollView.addSubview(medicalButton)
        
        medicalButton.translatesAutoresizingMaskIntoConstraints = false
        medicalButton.topAnchor.constraint(equalTo: employmentLabel.bottomAnchor,
                                          constant: top).isActive = true
        medicalButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        medicalButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        medicalButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка радиокнопки выбора работы не медицинским работником
    private func setupNotMedicalButton() {
        let top = 9.f
        notMedicalButton.contentHorizontalAlignment = .left
        notMedicalButton.setTitle(" Я работаю не по медицинскому образованию",
                                  for: .normal)
        notMedicalButton.titleLabel?.font = .systemFontOfSize(size: 12)
        notMedicalButton.setTitleColor(.white, for: .normal)
        notMedicalButton.isSelected = false
        notMedicalButton.addTarget(self, action: #selector(employmentButtonPressed), for: .touchUpInside)
        scrollView.addSubview(notMedicalButton)
        
        notMedicalButton.translatesAutoresizingMaskIntoConstraints = false
        notMedicalButton.topAnchor.constraint(equalTo: medicalButton.bottomAnchor,
                                              constant: top).isActive = true
        notMedicalButton.leadingAnchor.constraint(equalTo: medicalButton.leadingAnchor).isActive = true
        notMedicalButton.widthAnchor.constraint(equalTo: medicalButton.widthAnchor,
                                                multiplier: 1).isActive = true
        notMedicalButton.heightAnchor.constraint(equalTo: medicalButton.heightAnchor,
                                                 multiplier: 1).isActive = true
    }
    
    /// Установка радиокнопки скрытия информации о занятости
    private func setupHideEmploymentButton() {
        let top = 9.f
        hideEmploymentButton.contentHorizontalAlignment = .left
        hideEmploymentButton.setTitle(" Скрыть информацию о занятости в профиле",
                               for: .normal)
        hideEmploymentButton.titleLabel?.font = .systemFontOfSize(size: 12)
        hideEmploymentButton.setTitleColor(.white, for: .normal)
        hideEmploymentButton.isSelected = false
        scrollView.addSubview(hideEmploymentButton)
        
        hideEmploymentButton.translatesAutoresizingMaskIntoConstraints = false
        hideEmploymentButton.topAnchor.constraint(equalTo: notMedicalButton.bottomAnchor,
                                          constant: top).isActive = true
        hideEmploymentButton.leadingAnchor.constraint(equalTo: medicalButton.leadingAnchor).isActive = true
        hideEmploymentButton.widthAnchor.constraint(equalTo: medicalButton.widthAnchor, multiplier: 1).isActive = true
        hideEmploymentButton.heightAnchor.constraint(equalTo: medicalButton.heightAnchor, multiplier: 1).isActive = true
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let top = 110.f
        let width = 90.f
        let height = 30.f
        heightScroll += top + height + 34
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.update(isEnabled: true)
        scrollView.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - 10).isActive = true
        nextButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor,
                                        constant: top).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
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
    
    // MARK: - Buttons methods 
    @objc private func workPlusButtonPressed() {
        heightScroll += 35
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        jobTableViewHeight?.isActive = false
        jobTableViewHeight?.constant += 35
        jobTableViewHeight?.isActive = true
        jobRowCount += 1
        jobTableView.reloadData()
        if jobRowCount > 4 {
            workPlusButton.isHidden = true
        }
    }
    
    @objc private func specPlusButtonPressed() {
        heightScroll += 35
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        specTableViewHeight?.isActive = false
        specTableViewHeight?.constant += 35
        specTableViewHeight?.isActive = true
        specRowCount += 1
        specTableView.reloadData()
        if specRowCount > 4 {
            specPlusButton.isHidden = true
        }
    }
    
    @objc private func employmentButtonPressed() {
        if medicalButton.isSelected {
            presenter?.setEmployment(true)
        } else {
            presenter?.setEmployment(false)
        }
    }
    
    // MARK: - Navigation
    @objc private func nextButtonPressed() {
        presenter?.next()
    }
    
    @objc private func backButtonPressed() {
        presenter?.back()
    }
    
}

// MARK: - Table view
extension CreateProfileWorkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return textFieldHeight + 5
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
