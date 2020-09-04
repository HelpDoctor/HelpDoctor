//
//  SelectRepeatTimeViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class SelectRepeatTimeViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: SelectRepeatTimePresenterProtocol?
    
    // MARK: - Constants and variables
    private let headerHeight = 40.f
    private let heightLabel = 30.f
    private let heightTableView = 150.f
    private let widthTableView = 80.f
    private let leading = 20.f
    private var widthLabel = 0.f
    private let checkboxSize = 20.f
    private let hourLabel = UILabel()
    private let minutesLabel = UILabel()
    private let hoursTableView = UITableView()
    private let minutesTableView = UITableView()
    private let mondayLabel = UILabel()
    private let tuesdayLabel = UILabel()
    private let wednesdayLabel = UILabel()
    private let thursdayLabel = UILabel()
    private let fridayLabel = UILabel()
    private let saturdayLabel = UILabel()
    private let sundayLabel = UILabel()
    private let mondayCheckbox = CheckBox(type: .square)
    private let tuesdayCheckbox = CheckBox(type: .square)
    private let wednesdayCheckbox = CheckBox(type: .square)
    private let thursdayCheckbox = CheckBox(type: .square)
    private let fridayCheckbox = CheckBox(type: .square)
    private let saturdayCheckbox = CheckBox(type: .square)
    private let sundayCheckbox = CheckBox(type: .square)
    private let monthButton = RadioButton()
    private let monthLabel = UILabel()
    private let yearButton = RadioButton()
    private let yearLabel = UILabel()
    private let saveButton = HDButton(title: "Сохранить", fontSize: 18)
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        widthLabel = Session.width - (leading * 3) - checkboxSize
        view.backgroundColor = .backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Точное время повтора события",
                        font: .boldSystemFontOfSize(size: 14))
        setupHourLabel()
        setupMinutesLabel()
        setupHoursTableView()
        setupMinutesTableView()
        setupMondayLabel()
        setupMondayCheckbox()
        setupTuesdayLabel()
        setupTuesdayCheckbox()
        setupWednesdayLabel()
        setupWednesdayCheckbox()
        setupThursdayLabel()
        setupThursdayCheckbox()
        setupFridayLabel()
        setupFridayCheckbox()
        setupSaturdayLabel()
        setupSaturdayCheckbox()
        setupSundayLabel()
        setupSundayCheckbox()
        setupMonthButton()
        setupMonthLabel()
        setupYearButton()
        setupYearLabel()
        setupSaveButton()
        configureRadioButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup views
    private func setupHourLabel() {
        let top = 15.f
        hourLabel.font = .boldSystemFontOfSize(size: 14)
        hourLabel.textColor = .white
        hourLabel.text = "Часы"
        hourLabel.textAlignment = .center
        hourLabel.numberOfLines = 1
        view.addSubview(hourLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: (Session.width - leading) / 2).isActive = true
        hourLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: top + headerHeight).isActive = true
        hourLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        hourLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupMinutesLabel() {
        let top = 15.f
        minutesLabel.font = .boldSystemFontOfSize(size: 14)
        minutesLabel.textColor = .white
        minutesLabel.text = "Минуты"
        minutesLabel.textAlignment = .center
        minutesLabel.numberOfLines = 1
        view.addSubview(minutesLabel)
        
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        minutesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: (Session.width + leading) / 2).isActive = true
        minutesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: top + headerHeight).isActive = true
        minutesLabel.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        minutesLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
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
        hoursTableView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor,
                                            constant: top).isActive = true
        hoursTableView.leadingAnchor.constraint(equalTo: hourLabel.leadingAnchor).isActive = true
        hoursTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        hoursTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    private func setupMinutesTableView() {
        let top = 7.f
        view.addSubview(minutesTableView)
        minutesTableView.layer.cornerRadius = 5
        minutesTableView.register(SelectDateCell.self, forCellReuseIdentifier: "SelectDateCell")
        minutesTableView.dataSource = self
        minutesTableView.delegate = self
        minutesTableView.backgroundColor = .backgroundColor
        minutesTableView.separatorStyle = .none
        minutesTableView.showsVerticalScrollIndicator = false
        
        minutesTableView.translatesAutoresizingMaskIntoConstraints = false
        minutesTableView.topAnchor.constraint(equalTo: minutesLabel.bottomAnchor,
                                              constant: top).isActive = true
        minutesTableView.leadingAnchor.constraint(equalTo: minutesLabel.leadingAnchor).isActive = true
        minutesTableView.widthAnchor.constraint(equalToConstant: widthTableView).isActive = true
        minutesTableView.heightAnchor.constraint(equalToConstant: heightTableView).isActive = true
    }
    
    private func setupMondayLabel() {
        mondayLabel.font = .systemFontOfSize(size: 14)
        mondayLabel.textColor = .white
        mondayLabel.text = "Понедельник"
        mondayLabel.textAlignment = .left
        mondayLabel.numberOfLines = 1
        view.addSubview(mondayLabel)
        
        mondayLabel.translatesAutoresizingMaskIntoConstraints = false
        mondayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: leading).isActive = true
        mondayLabel.topAnchor.constraint(equalTo: hoursTableView.bottomAnchor,
                                         constant: heightLabel).isActive = true
        mondayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        mondayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupMondayCheckbox() {
        mondayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(mondayCheckbox)
        
        mondayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        mondayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -leading).isActive = true
        mondayCheckbox.centerYAnchor.constraint(equalTo: mondayLabel.centerYAnchor).isActive = true
        mondayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        mondayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupTuesdayLabel() {
        tuesdayLabel.font = .systemFontOfSize(size: 14)
        tuesdayLabel.textColor = .white
        tuesdayLabel.text = "Вторник"
        tuesdayLabel.textAlignment = .left
        tuesdayLabel.numberOfLines = 1
        view.addSubview(tuesdayLabel)
        
        tuesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        tuesdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: leading).isActive = true
        tuesdayLabel.topAnchor.constraint(equalTo: mondayLabel.bottomAnchor).isActive = true
        tuesdayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        tuesdayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupTuesdayCheckbox() {
        tuesdayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(tuesdayCheckbox)
        
        tuesdayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        tuesdayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -leading).isActive = true
        tuesdayCheckbox.centerYAnchor.constraint(equalTo: tuesdayLabel.centerYAnchor).isActive = true
        tuesdayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        tuesdayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupWednesdayLabel() {
        wednesdayLabel.font = .systemFontOfSize(size: 14)
        wednesdayLabel.textColor = .white
        wednesdayLabel.text = "Среда"
        wednesdayLabel.textAlignment = .left
        wednesdayLabel.numberOfLines = 1
        view.addSubview(wednesdayLabel)
        
        wednesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        wednesdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: leading).isActive = true
        wednesdayLabel.topAnchor.constraint(equalTo: tuesdayLabel.bottomAnchor).isActive = true
        wednesdayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        wednesdayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupWednesdayCheckbox() {
        wednesdayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(wednesdayCheckbox)
        
        wednesdayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        wednesdayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -leading).isActive = true
        wednesdayCheckbox.centerYAnchor.constraint(equalTo: wednesdayLabel.centerYAnchor).isActive = true
        wednesdayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        wednesdayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupThursdayLabel() {
        thursdayLabel.font = .systemFontOfSize(size: 14)
        thursdayLabel.textColor = .white
        thursdayLabel.text = "Четверг"
        thursdayLabel.textAlignment = .left
        thursdayLabel.numberOfLines = 1
        view.addSubview(thursdayLabel)
        
        thursdayLabel.translatesAutoresizingMaskIntoConstraints = false
        thursdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: leading).isActive = true
        thursdayLabel.topAnchor.constraint(equalTo: wednesdayLabel.bottomAnchor).isActive = true
        thursdayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        thursdayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupThursdayCheckbox() {
        thursdayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(thursdayCheckbox)
        
        thursdayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        thursdayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -leading).isActive = true
        thursdayCheckbox.centerYAnchor.constraint(equalTo: thursdayLabel.centerYAnchor).isActive = true
        thursdayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        thursdayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupFridayLabel() {
        fridayLabel.font = .systemFontOfSize(size: 14)
        fridayLabel.textColor = .white
        fridayLabel.text = "Пятница"
        fridayLabel.textAlignment = .left
        fridayLabel.numberOfLines = 1
        view.addSubview(fridayLabel)
        
        fridayLabel.translatesAutoresizingMaskIntoConstraints = false
        fridayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: leading).isActive = true
        fridayLabel.topAnchor.constraint(equalTo: thursdayLabel.bottomAnchor).isActive = true
        fridayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        fridayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupFridayCheckbox() {
        fridayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(fridayCheckbox)
        
        fridayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        fridayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -leading).isActive = true
        fridayCheckbox.centerYAnchor.constraint(equalTo: fridayLabel.centerYAnchor).isActive = true
        fridayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        fridayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupSaturdayLabel() {
        saturdayLabel.font = .systemFontOfSize(size: 14)
        saturdayLabel.textColor = .white
        saturdayLabel.text = "Суббота"
        saturdayLabel.textAlignment = .left
        saturdayLabel.numberOfLines = 1
        view.addSubview(saturdayLabel)
        
        saturdayLabel.translatesAutoresizingMaskIntoConstraints = false
        saturdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: leading).isActive = true
        saturdayLabel.topAnchor.constraint(equalTo: fridayLabel.bottomAnchor).isActive = true
        saturdayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        saturdayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupSaturdayCheckbox() {
        saturdayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(saturdayCheckbox)
        
        saturdayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        saturdayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -leading).isActive = true
        saturdayCheckbox.centerYAnchor.constraint(equalTo: saturdayLabel.centerYAnchor).isActive = true
        saturdayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        saturdayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupSundayLabel() {
        sundayLabel.font = .systemFontOfSize(size: 14)
        sundayLabel.textColor = .white
        sundayLabel.text = "Воскресенье"
        sundayLabel.textAlignment = .left
        sundayLabel.numberOfLines = 1
        view.addSubview(sundayLabel)
        
        sundayLabel.translatesAutoresizingMaskIntoConstraints = false
        sundayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: leading).isActive = true
        sundayLabel.topAnchor.constraint(equalTo: saturdayLabel.bottomAnchor).isActive = true
        sundayLabel.widthAnchor.constraint(equalToConstant: widthLabel).isActive = true
        sundayLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupSundayCheckbox() {
        sundayCheckbox.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(sundayCheckbox)
        
        sundayCheckbox.translatesAutoresizingMaskIntoConstraints = false
        sundayCheckbox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -leading).isActive = true
        sundayCheckbox.centerYAnchor.constraint(equalTo: sundayLabel.centerYAnchor).isActive = true
        sundayCheckbox.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        sundayCheckbox.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupMonthButton() {
        monthButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        monthButton.isSelected = false
        view.addSubview(monthButton)
        
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        monthButton.topAnchor.constraint(equalTo: sundayLabel.bottomAnchor,
                                         constant: heightLabel / 2).isActive = true
        monthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: leading).isActive = true
        monthButton.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        monthButton.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupMonthLabel() {
        monthLabel.font = .mediumSystemFontOfSize(size: 14)
        monthLabel.textColor = .white
        monthLabel.text = "Каждый месяц"
        monthLabel.textAlignment = .left
        monthLabel.numberOfLines = 1
        view.addSubview(monthLabel)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.leadingAnchor.constraint(equalTo: monthButton.trailingAnchor,
                                            constant: leading).isActive = true
        monthLabel.centerYAnchor.constraint(equalTo: monthButton.centerYAnchor).isActive = true
        monthLabel.widthAnchor.constraint(equalToConstant: Session.width - 80).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupYearButton() {
        yearButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        yearButton.isSelected = false
        view.addSubview(yearButton)
        
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        yearButton.topAnchor.constraint(equalTo: monthButton.topAnchor).isActive = true
        yearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: Session.width / 2).isActive = true
        yearButton.widthAnchor.constraint(equalToConstant: checkboxSize).isActive = true
        yearButton.heightAnchor.constraint(equalToConstant: checkboxSize).isActive = true
    }
    
    private func setupYearLabel() {
        yearLabel.font = .mediumSystemFontOfSize(size: 14)
        yearLabel.textColor = .white
        yearLabel.text = "Каждый год"
        yearLabel.textAlignment = .left
        yearLabel.numberOfLines = 1
        view.addSubview(yearLabel)
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leadingAnchor.constraint(equalTo: yearButton.trailingAnchor,
                                           constant: leading).isActive = true
        yearLabel.centerYAnchor.constraint(equalTo: yearButton.centerYAnchor).isActive = true
        yearLabel.widthAnchor.constraint(equalToConstant: Session.width - 80).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,
                                        constant: heightLabel / 2).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -leading).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func configureRadioButtons() {
        monthButton.alternateButton = [yearButton]
        yearButton.alternateButton = [monthButton]
    }
    
    // MARK: - Buttons methods
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc private func saveButtonPressed() {
        let hours = hoursTableView.indexPathForSelectedRow?.item
        let minutes = minutesTableView.indexPathForSelectedRow?.item
        presenter?.saveDate(indexHours: hours, indexMinutes: minutes)
    }
    
}

// MARK: - UITableViewDelegate
extension SelectRepeatTimeViewController: UITableViewDelegate {
    
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
extension SelectRepeatTimeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.hoursTableView {
            return 24
        } else {
            return 60
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDateCell",
                                                       for: indexPath) as? SelectDateCell
            else { return UITableViewCell() }
        
        if tableView == self.hoursTableView {
            cell.configure(title: presenter?.getHoursFromArray(indexPath.row))
        } else {
            cell.configure(minutes: presenter?.getMinutesFromArray(indexPath.row))
        }
        
        return cell
    }
    
}
