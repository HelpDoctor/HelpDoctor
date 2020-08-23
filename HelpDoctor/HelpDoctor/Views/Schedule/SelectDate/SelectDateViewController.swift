//
//  SelectDateViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SelectDatePresenterProtocol?
    weak var delegate: SelectDateControllerDelegate?
    
    // MARK: - Constants and variables
    private let heightTopLabel = 30.f
    private let heightTableView = 150.f
    private let widthTableView = (Session.width - 80) / 3
    private let topLabel = UILabel()
    private let todayView = UIView()
    private let todayLabel = UILabel()
    private let todayDateLabel = UILabel()
    private let todayDayOfWeekLabel = UILabel()
    private let dayLabel = UILabel()
    private let hourLabel = UILabel()
    private let minutesLabel = UILabel()
    private let datesTableView = UITableView()
    private let hoursTableView = UITableView()
    private let minutesTableView = UITableView()
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
        setupDayLabel()
        setupHourLabel()
        setupMinutesLabel()
        setupDatesTableView()
        setupHoursTableView()
        setupMinutesTableView()
        setupSaveButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupTopLabel() {
        topLabel.backgroundColor = .searchBarTintColor
        topLabel.font = .mediumSystemFontOfSize(size: 14)
        topLabel.textColor = .white
        topLabel.text = "Выбор даты"
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
    
    private func setupDayLabel() {
        let leading = 20.f
        let top = 15.f
        dayLabel.font = .boldSystemFontOfSize(size: 14)
        dayLabel.textColor = .white
        dayLabel.text = "День"
        dayLabel.textAlignment = .center
        dayLabel.numberOfLines = 1
        view.addSubview(dayLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: leading).isActive = true
        dayLabel.topAnchor.constraint(equalTo: todayView.bottomAnchor,
                                      constant: top).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupHourLabel() {
        let leading = 20.f
        let top = 15.f
        hourLabel.font = .boldSystemFontOfSize(size: 14)
        hourLabel.textColor = .white
        hourLabel.text = "Часы"
        hourLabel.textAlignment = .center
        hourLabel.numberOfLines = 1
        view.addSubview(hourLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor,
                                           constant: leading).isActive = true
        hourLabel.topAnchor.constraint(equalTo: todayView.bottomAnchor,
                                       constant: top).isActive = true
        hourLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        hourLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupMinutesLabel() {
        let leading = 20.f
        let top = 15.f
        minutesLabel.font = .boldSystemFontOfSize(size: 14)
        minutesLabel.textColor = .white
        minutesLabel.text = "Минуты"
        minutesLabel.textAlignment = .center
        minutesLabel.numberOfLines = 1
        view.addSubview(minutesLabel)
        
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        minutesLabel.leadingAnchor.constraint(equalTo: hourLabel.trailingAnchor,
                                              constant: leading).isActive = true
        minutesLabel.topAnchor.constraint(equalTo: todayView.bottomAnchor,
                                          constant: top).isActive = true
        minutesLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        minutesLabel.heightAnchor.constraint(equalToConstant: heightTopLabel).isActive = true
    }
    
    private func setupDatesTableView() {
        let top = 7.f
        let leading = 20.f
        view.addSubview(datesTableView)
        datesTableView.layer.cornerRadius = 5
        datesTableView.register(SelectDateCell.self, forCellReuseIdentifier: "SelectDateCell")
        datesTableView.dataSource = self
        datesTableView.delegate = self
        datesTableView.backgroundColor = .backgroundColor
        datesTableView.separatorStyle = .none
        datesTableView.showsVerticalScrollIndicator = false
        datesTableView.selectRow(at: IndexPath(row: presenter?.selectTodayRow() ?? 0, section: 0),
                                 animated: true,
                                 scrollPosition: .top)
        
        datesTableView.translatesAutoresizingMaskIntoConstraints = false
        datesTableView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,
                                            constant: top).isActive = true
        datesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: leading).isActive = true
        datesTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        datesTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    private func setupHoursTableView() {
        let top = 7.f
        view.addSubview(hoursTableView)
        hoursTableView.layer.cornerRadius = 5
        hoursTableView.register(SelectDateCell.self, forCellReuseIdentifier: "SelectDateCell")
        hoursTableView.dataSource = self
        hoursTableView.delegate = self
        hoursTableView.backgroundColor = .backgroundColor
        hoursTableView.separatorStyle = .none
        hoursTableView.showsVerticalScrollIndicator = false
        
        hoursTableView.translatesAutoresizingMaskIntoConstraints = false
        hoursTableView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,
                                            constant: top).isActive = true
        hoursTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hoursTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        hoursTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    private func setupMinutesTableView() {
        let top = 7.f
        let leading = 20.f
        view.addSubview(minutesTableView)
        minutesTableView.layer.cornerRadius = 5
        minutesTableView.register(SelectDateCell.self, forCellReuseIdentifier: "SelectDateCell")
        minutesTableView.dataSource = self
        minutesTableView.delegate = self
        minutesTableView.backgroundColor = .backgroundColor
        minutesTableView.separatorStyle = .none
        minutesTableView.showsVerticalScrollIndicator = false
        
        minutesTableView.translatesAutoresizingMaskIntoConstraints = false
        minutesTableView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,
                                              constant: top).isActive = true
        minutesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -leading).isActive = true
        minutesTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        minutesTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    
    private func setupSaveButton() {
        let top = 25.f
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: hoursTableView.bottomAnchor,
                                        constant: top).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Buttons methods
    @objc private func saveButtonPressed() {
        let date = datesTableView.indexPathForSelectedRow?.item
        let hours = hoursTableView.indexPathForSelectedRow?.item
        let minutes = minutesTableView.indexPathForSelectedRow?.item
        presenter?.saveDate(indexDate: date, indexHours: hours, indexMinutes: minutes)
    }
    
}

// MARK: - UITableViewDelegate
extension SelectDateViewController: UITableViewDelegate {
    
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
extension SelectDateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.datesTableView {
            return presenter?.getCountDates() ?? 0
        } else if tableView == self.hoursTableView {
            return 24
        } else {
            return 60
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDateCell",
                                                       for: indexPath) as? SelectDateCell
            else { return UITableViewCell() }
        
        if tableView == self.datesTableView {
            cell.configure(presenter?.getDateFromArray(indexPath.row))
        } else if tableView == self.hoursTableView {
            cell.configure(title: presenter?.getHoursFromArray(indexPath.row))
        } else {
            cell.configure(minutes: presenter?.getMinutesFromArray(indexPath.row))
        }
        
        return cell
    }
    
}
