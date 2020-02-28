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
    private let scrollView = UIScrollView()
    private let step4TitleLabel = UILabel()
    private let step4Label = UILabel()
    private let regionTextField = UITextField()
    private let regionSearchButton = SearchButton()
    private let cityTextField = UITextField()
    private let citySearchButton = SearchButton()
    private let step5TitleLabel = UILabel()
    private let step5TopLabel = UILabel()
    private let jobTableView = UITableView()
    private let workPlusButton = PlusButton()
    private let step5BottomLabel = UILabel()
    private let specTableView = UITableView()
    private let specPlusButton = PlusButton()
    private let backButton = UIButton()
    private let nextButton = UIButton()
    private var jobTableViewHeight: NSLayoutConstraint?
    private var specTableViewHeight: NSLayoutConstraint?
    private var nextButtonTop: NSLayoutConstraint?
    private var backButtonTop: NSLayoutConstraint?
    private var jobRowCount = 2
    private var specRowCount = 2
    private var heightScroll = Session.height
    private let widthTextField: CGFloat = Session.width - 60
    private let heightTextField: CGFloat = 30
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupBackground()
        setupScrollView()
        setupHeaderView()
        setupStep4TitleLabel()
        setupStep4Label()
        setupRegionTextField()
//        setupRegionSearchButton()
        setupCityTextField()
//        setupCitySearchButton()
        setupStep5TitleLabel()
        setupStep5TopLabel()
        setupJobTableView()
        setupWorkPlusButton()
        setupStep5BottomLabel()
        setupSpecTableView()
        setupSpecPlusButton()
        setupBackButton()
        setupNextButton()
        addSwipeGestureToBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.statusBarBackgroundColor = .clear
        view.viewWithTag(998)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
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
    
    func reloadJobTableView() {
        jobTableView.reloadData()
    }
    
    func reloadSpecTableView() {
        specTableView.reloadData()
    }
    
    // MARK: - Setup views
    /// Установка UIScrollView для сдвига экрана при появлении клавиатуры
    private func setupScrollView() {
        let top: CGFloat = 60
        scrollView.delegate = self
        heightScroll = top
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: top).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    /// Установка надписи
    private func setupStep4TitleLabel() {
        let top: CGFloat = 16
        let height: CGFloat = 20
        heightScroll += top + height
        step4TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step4TitleLabel.textColor = .white
        step4TitleLabel.text = "Шаг 4"
        step4TitleLabel.textAlignment = .center
        scrollView.addSubview(step4TitleLabel)
        
        step4TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step4TitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                             constant: top).isActive = true
        step4TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4TitleLabel.widthAnchor.constraint(equalToConstant: Session.width).isActive = true
        step4TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи указания места жительства
    private func setupStep4Label() {
        let top: CGFloat = 3
        let height: CGFloat = 51
        heightScroll += top + height
        step4Label.font = UIFont.systemFontOfSize(size: 14)
        step4Label.textColor = .white
        step4Label.text = "Укажите свое место жительства"
        step4Label.textAlignment = .left
        step4Label.numberOfLines = 0
        scrollView.addSubview(step4Label)
        
        step4Label.translatesAutoresizingMaskIntoConstraints = false
        step4Label.topAnchor.constraint(equalTo: step4TitleLabel.bottomAnchor,
                                        constant: top).isActive = true
        step4Label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step4Label.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка поля ввода региона места жительства
    private func setupRegionTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(regionSearchButtonPressed))
        let top: CGFloat = 5
        heightScroll += top + heightTextField

        regionTextField.font = UIFont.systemFontOfSize(size: 14)
        regionTextField.textColor = .textFieldTextColor
        regionTextField.textAlignment = .left
        regionTextField.backgroundColor = .white
        regionTextField.layer.cornerRadius = 5
        regionTextField.leftView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 8,
                                             height: regionTextField.frame.height))
        regionTextField.leftViewMode = .always
        regionTextField.attributedPlaceholder = redStar(text: "Субъект*")
        regionTextField.addGestureRecognizer(tap)
        scrollView.addSubview(regionTextField)
        
        regionTextField.translatesAutoresizingMaskIntoConstraints = false
        regionTextField.topAnchor.constraint(equalTo: step4Label.bottomAnchor,
                                             constant: top).isActive = true
        regionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        regionTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        regionTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка кнопки выбора из списка региона места жительства
    private func setupRegionSearchButton() {
        regionSearchButton.addTarget(self, action: #selector(regionSearchButtonPressed), for: .touchUpInside)
        view.addSubview(regionSearchButton)
        
        regionSearchButton.translatesAutoresizingMaskIntoConstraints = false
        regionSearchButton.topAnchor.constraint(equalTo: regionTextField.topAnchor,
                                                constant: 5).isActive = true
        regionSearchButton.trailingAnchor.constraint(equalTo: regionTextField.trailingAnchor,
                                                     constant: -5).isActive = true
        regionSearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        regionSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка поля ввода города места жительства
    private func setupCityTextField() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(citySearchButtonPressed))
        let top: CGFloat = 5
        heightScroll += top + heightTextField
        cityTextField.font = UIFont.systemFontOfSize(size: 14)
        cityTextField.textColor = .textFieldTextColor
        cityTextField.textAlignment = .left
        cityTextField.backgroundColor = .white
        cityTextField.layer.cornerRadius = 5
        cityTextField.leftView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 8,
                                             height: regionTextField.frame.height))
        cityTextField.leftViewMode = .always
        cityTextField.attributedPlaceholder = redStar(text: "Город / район*")
        cityTextField.addGestureRecognizer(tap)
        scrollView.addSubview(cityTextField)
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: regionTextField.bottomAnchor,
                                           constant: top).isActive = true
        cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cityTextField.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: heightTextField).isActive = true
    }
    
    /// Установка кнопки выбора из списка города места жительства
    private func setupCitySearchButton() {
        citySearchButton.addTarget(self, action: #selector(citySearchButtonPressed), for: .touchUpInside)
        view.addSubview(citySearchButton)
        
        citySearchButton.translatesAutoresizingMaskIntoConstraints = false
        citySearchButton.topAnchor.constraint(equalTo: cityTextField.topAnchor,
                                              constant: 5).isActive = true
        citySearchButton.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor,
                                                   constant: -5).isActive = true
        citySearchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        citySearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /// Установка надписи
    private func setupStep5TitleLabel() {
        let width: CGFloat = Session.width
        let top: CGFloat = 12
        let height: CGFloat = 20
        heightScroll += top + height
        step5TitleLabel.font = UIFont.boldSystemFontOfSize(size: 18)
        step5TitleLabel.textColor = .white
        step5TitleLabel.text = "Шаг 5"
        step5TitleLabel.textAlignment = .center
        scrollView.addSubview(step5TitleLabel)
        
        step5TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TitleLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor,
                                             constant: top).isActive = true
        step5TitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TitleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        step5TitleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи указания места работы
    private func setupStep5TopLabel() {
        let top: CGFloat = 1
        let height: CGFloat = 34
        heightScroll += top + height
        step5TopLabel.font = UIFont.systemFontOfSize(size: 14)
        step5TopLabel.textColor = .white
        step5TopLabel.numberOfLines = 0
        step5TopLabel.text = "Заполните данные о своей профессиональной деятельности"
        step5TopLabel.textAlignment = .left
        scrollView.addSubview(step5TopLabel)
        
        step5TopLabel.translatesAutoresizingMaskIntoConstraints = false
        step5TopLabel.topAnchor.constraint(equalTo: step5TitleLabel.bottomAnchor,
                                           constant: top).isActive = true
        step5TopLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5TopLabel.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        step5TopLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupJobTableView() {
        let top: CGFloat = 5
        let height: CGFloat = 70
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
        jobTableView.topAnchor.constraint(equalTo: step5TopLabel.bottomAnchor,
                                          constant: top).isActive = true
        jobTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        jobTableView.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        jobTableViewHeight = jobTableView.heightAnchor.constraint(equalToConstant: height)
        jobTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления места работы
    private func setupWorkPlusButton() {
        let leading: CGFloat = 30
        let top: CGFloat = 5
        let height: CGFloat = 20
        heightScroll += top + height
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
    private func setupStep5BottomLabel() {
        let top: CGFloat = 40
        let height: CGFloat = 15
        heightScroll += top + height
        step5BottomLabel.font = UIFont.systemFontOfSize(size: 14)
        step5BottomLabel.textColor = .white
        step5BottomLabel.text = "Укажите медицинскую специализацию"
        step5BottomLabel.textAlignment = .left
        scrollView.addSubview(step5BottomLabel)
        
        step5BottomLabel.translatesAutoresizingMaskIntoConstraints = false
        step5BottomLabel.topAnchor.constraint(equalTo: jobTableView.bottomAnchor,
                                              constant: top).isActive = true
        step5BottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        step5BottomLabel.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        step5BottomLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSpecTableView() {
        let top: CGFloat = 5
        let height: CGFloat = 70
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
        specTableView.topAnchor.constraint(equalTo: step5BottomLabel.bottomAnchor,
                                          constant: top).isActive = true
        specTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        specTableView.widthAnchor.constraint(equalToConstant: widthTextField).isActive = true
        specTableViewHeight = specTableView.heightAnchor.constraint(equalToConstant: height)
        specTableViewHeight?.isActive = true
    }
    
    /// Установка кнопки добавления медицинской специализации
    private func setupSpecPlusButton() {
        let leading: CGFloat = 30
        let top: CGFloat = 5
        let height: CGFloat = 20
        heightScroll += top + height
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
    
    /// Установки кнопки перехода к предыдущему экрану
    private func setupBackButton() {
        let leading: CGFloat = 36
        let width: CGFloat = 80
        let top: CGFloat = 30
        let height: CGFloat = 25
        heightScroll += top + height
        scrollView.contentSize = CGSize(width: Session.width, height: heightScroll)
        
        let titleButton = "< Назад"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        backButton.titleLabel?.textColor = .white
        backButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        if heightScroll > Session.height {
            backButtonTop = backButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            backButtonTop?.isActive = true
        } else {
            backButtonTop = backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            backButtonTop?.isActive = true
        }
        
    }
    
    /// Установка кнопки перехода к следующему экрану
    private func setupNextButton() {
        let leading: CGFloat = 36
        let width: CGFloat = 80
        let top: CGFloat = 30
        let height: CGFloat = 25
        
        let titleButton = "Далее >"
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        nextButton.titleLabel?.font = UIFont.boldSystemFontOfSize(size: 18)
        nextButton.titleLabel?.textColor = .white
        nextButton.setTitle(titleButton, for: .normal)
        scrollView.addSubview(nextButton)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: Session.width - leading).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        if heightScroll > Session.height {
            nextButtonTop = nextButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            nextButtonTop?.isActive = true
        } else {
            nextButtonTop = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            nextButtonTop?.isActive = true
        }
    }
    
    /// Добавляет свайп влево для перехода назад
    private func addSwipeGestureToBack() {
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(backButtonPressed))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - IBActions
    
    // MARK: - Buttons methods
    @objc private func regionSearchButtonPressed() {
        presenter?.regionSearch()
    }
    
    @objc private func citySearchButtonPressed() {
        presenter?.citySearch()
    }
    
    @objc private func workPlusButtonPressed() {
        let top: CGFloat = 30
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
        backButtonTop?.isActive = false
        nextButtonTop?.isActive = false
        if heightScroll > Session.height {
            backButtonTop = backButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            backButtonTop?.isActive = true
            
            nextButtonTop = nextButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            nextButtonTop?.isActive = true
        } else {
            backButtonTop = backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            backButtonTop?.isActive = true
            nextButtonTop = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            nextButtonTop?.isActive = true
        }
        
    }
    
    @objc private func specPlusButtonPressed() {
        let top: CGFloat = 30
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
        backButtonTop?.isActive = false
        nextButtonTop?.isActive = false
        if heightScroll > Session.height {
            backButtonTop = backButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            backButtonTop?.isActive = true
            
            nextButtonTop = nextButton.topAnchor.constraint(equalTo: specTableView.bottomAnchor,
                                                            constant: top)
            nextButtonTop?.isActive = true
        } else {
            backButtonTop = backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            backButtonTop?.isActive = true
            nextButtonTop = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            nextButtonTop?.isActive = true
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
extension CreateProfileWorkViewController: UITableViewDelegate { }

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
                    value = redStar(text: "Основное место работы*")
                default:
                    value = redStar(text: "Дополнительное место работы")
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
                    value = redStar(text: "Основная специализация*")
                default:
                    value = redStar(text: "Дополнительная специализация")
                }
                cell.configure(value)
            } else {
                cell.configure(spec)
            }
        }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
        
    }
    
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
