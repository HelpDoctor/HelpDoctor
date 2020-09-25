//
//  SelectYearViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectYearViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SelectYearPresenterProtocol?
    
    // MARK: - Constants and variables
    private let leading = 20.f
    private let heightTopLabel = 30.f
    private let heightTableView = 150.f
    private let widthTableView = Session.width - 40
    private let topLabel = UILabel()
    private let todayView = UIView()
    private let todayLabel = UILabel()
    private let todayDateLabel = UILabel()
    private let todayDayOfWeekLabel = UILabel()
    private let yearLabel = UILabel()
    private let yearsTableView = UITableView()
    private let saveButton = HDButton(title: "Готово", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupTopLabel()
        setupTodayView()
        setupTodayLabel()
        setupTodayDateLabel()
        setupTodayDayOfWeekLabel()
        setupYearLabel()
        setupYearsTableView()
        setupSaveButton()
        presenter?.setSelectDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Public methods
    func setSelectDate(_ date: IndexPath) {
        yearsTableView.selectRow(at: date, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.backgroundColor = .searchBarTintColor
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Выбор года окончания учебного заведения"
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupTodayView() {
        todayView.backgroundColor = .white
        view.addSubview(todayView)
        
        todayView.translatesAutoresizingMaskIntoConstraints = false
        todayView.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        todayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        todayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        todayView.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupTodayLabel() {
        let leading = 10.f
        todayLabel.font = .boldSystemFontOfSize(size: 14)
        todayLabel.textColor = .black
        todayLabel.text = "Сегодня"
        todayLabel.textAlignment = .left
        todayLabel.numberOfLines = 1
        todayView.addSubview(todayLabel)
        
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.leadingAnchor.constraint(equalTo: todayView.leadingAnchor,
                                            constant: leading).isActive = true
        todayLabel.centerYAnchor.constraint(equalTo: todayView.centerYAnchor).isActive = true
        todayLabel.widthAnchor.constraint(equalTo: todayView.widthAnchor, multiplier: 1 / 3).isActive = true
        todayLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupTodayDateLabel() {
        todayDateLabel.font = .boldSystemFontOfSize(size: 14)
        todayDateLabel.textColor = .black
        todayDateLabel.text = presenter?.getCurrentDate(date: Date())
        todayDateLabel.textAlignment = .center
        todayDateLabel.numberOfLines = 1
        todayView.addSubview(todayDateLabel)
        
        todayDateLabel.translatesAutoresizingMaskIntoConstraints = false
        todayDateLabel.centerXAnchor.constraint(equalTo: todayView.centerXAnchor).isActive = true
        todayDateLabel.centerYAnchor.constraint(equalTo: todayView.centerYAnchor).isActive = true
        todayDateLabel.widthAnchor.constraint(equalTo: todayView.widthAnchor, multiplier: 1 / 3).isActive = true
        todayDateLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupTodayDayOfWeekLabel() {
        let leading = 10.f
        todayDayOfWeekLabel.font = .boldSystemFontOfSize(size: 14)
        todayDayOfWeekLabel.textColor = UIColor(red: 0.675, green: 0.125, blue: 0.529, alpha: 1)
        todayDayOfWeekLabel.text = presenter?.getCurrentDayOfWeek(date: Date())
        todayDayOfWeekLabel.textAlignment = .right
        todayDayOfWeekLabel.numberOfLines = 1
        todayView.addSubview(todayDayOfWeekLabel)
        
        todayDayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        todayDayOfWeekLabel.trailingAnchor.constraint(equalTo: todayView.trailingAnchor,
                                                      constant: -leading).isActive = true
        todayDayOfWeekLabel.centerYAnchor.constraint(equalTo: todayView.centerYAnchor).isActive = true
        todayDayOfWeekLabel.widthAnchor.constraint(equalTo: todayView.widthAnchor, multiplier: 1 / 3).isActive = true
        todayDayOfWeekLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupYearLabel() {
        let top = 15.f
        yearLabel.font = .boldSystemFontOfSize(size: 14)
        yearLabel.textColor = .white
        yearLabel.text = "Год"
        yearLabel.textAlignment = .center
        yearLabel.numberOfLines = 1
        view.addSubview(yearLabel)
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: leading).isActive = true
        yearLabel.topAnchor.constraint(equalTo: todayView.bottomAnchor,
                                      constant: top).isActive = true
        yearLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupYearsTableView() {
        let top = 7.f
        view.addSubview(yearsTableView)
        yearsTableView.layer.cornerRadius = 5
        yearsTableView.register(SelectDateCell.self, forCellReuseIdentifier: "SelectDateCell")
        yearsTableView.dataSource = self
        yearsTableView.delegate = self
        yearsTableView.backgroundColor = .backgroundColor
        yearsTableView.separatorStyle = .none
        yearsTableView.showsVerticalScrollIndicator = false
        
        yearsTableView.translatesAutoresizingMaskIntoConstraints = false
        yearsTableView.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,
                                            constant: top).isActive = true
        yearsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: leading).isActive = true
        yearsTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        yearsTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    private func setupSaveButton() {
        let top = 25.f
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: yearsTableView.bottomAnchor,
                                        constant: top).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func saveButtonPressed() {
        let date = yearsTableView.indexPathForSelectedRow?.item
        presenter?.saveDate(indexDate: date)
    }
    
}

// MARK: - UITableViewDelegate
extension SelectYearViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = false
    }
}

// MARK: - UITableViewDataSource
extension SelectYearViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return presenter?.getCountDates() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDateCell",
                                                       for: indexPath) as? SelectDateCell
        else { return UITableViewCell() }
        cell.configure(minutes: presenter?.getDateFromArray(indexPath.row))
        return cell
    }
}
