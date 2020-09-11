//
//  StartScheduleViewController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import JTAppleCalendar
import UIKit

class StartScheduleViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: StartSchedulePresenterProtocol?
    
    // MARK: - Constants
    private let headerHeight = 40.f
    private let heightTopView = 70.f
    private let calendarView = JTACMonthView()
    private let topView = UIView()
    private let appointmentImage = UIImageView()
    private let appointmentLabel = UILabel()
    private let appointmentCount = UILabel()
    private let importantImage = UIImageView()
    private let importantLabel = UILabel()
    private let importantCount = UILabel()
    private let tableView = UITableView()
    private var addButton = PlusButton()
    private var currentDate = Date()
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupHeaderView(color: .tabBarColor,
                        height: headerHeight,
                        presenter: presenter,
                        title: "Расписание",
                        font: .boldSystemFontOfSize(size: 14))
        setupCalendarView()
        setupTopView()
        setupAppointmentImage()
        setupAppointmentLabel()
        setupAppointmentCount()
        setupImportantImage()
        setupImportantLabel()
        setupImportantCount()
        setupTableView()
        setupAddButton()
        presenter?.getEvents(newDate: currentDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarBackgroundColor(color: .tabBarColor)
        tabBarController?.tabBar.isHidden = false
        refresh(tableView)
    }
    
    // MARK: - Public methods
    func reloadTableView() {
        tableView.reloadData()
        let countPatients = presenter?.getCountPatients()
        if countPatients == 0 || countPatients == nil {
            appointmentCount.text = ""
        } else {
            appointmentCount.text = countPatients?.description
        }
        
        let countMajorEvents = presenter?.getCountMajorEvents()
        if countMajorEvents == 0 || countMajorEvents == nil {
            importantCount.text = ""
        } else {
            importantCount.text = countMajorEvents?.description
        }
    }
    
    func setDate(date: Date = Date()) {
        currentDate = date
    }
    
    func getDate() -> Date {
        return currentDate
    }
    
    // MARK: - Setup views
    private func setupCalendarView() {
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.backgroundColor = .white
        calendarView.scrollDirection = .horizontal
        calendarView.scrollToDate(Date() - (86400 * 3))
        calendarView.selectDates([Date()])
        //        calendarView.allowsMultipleSelection = true
        //        calendarView.allowsRangedSelection = true
        calendarView.sectionInset.bottom = 0
        calendarView.sectionInset.top = 0
        calendarView.sectionInset.left = 0
        calendarView.sectionInset.right = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.minimumLineSpacing = 0
        view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: headerHeight).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTopView() {
        topView.backgroundColor = .searchBarTintColor
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: headerHeight + 50).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: heightTopView).isActive = true
    }
    
    private func setupAppointmentImage() {
        let top = 10.f
        let leading = 10.f
        let size = 20.f
        let imageName = "AppointmentIcon"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        appointmentImage.image = image
        topView.addSubview(appointmentImage)
        
        appointmentImage.translatesAutoresizingMaskIntoConstraints = false
        appointmentImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: top).isActive = true
        appointmentImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: leading).isActive = true
        appointmentImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        appointmentImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupAppointmentLabel() {
        let leading = 10.f
        let width = 180.f
        appointmentLabel.font = .mediumSystemFontOfSize(size: 14)
        appointmentLabel.textColor = .white
        appointmentLabel.text = "К вам на прием записаны:"
        appointmentLabel.textAlignment = .left
        topView.addSubview(appointmentLabel)
        
        appointmentLabel.translatesAutoresizingMaskIntoConstraints = false
        appointmentLabel.leadingAnchor.constraint(equalTo: appointmentImage.trailingAnchor,
                                                  constant: leading).isActive = true
        appointmentLabel.centerYAnchor.constraint(equalTo: appointmentImage.centerYAnchor).isActive = true
        appointmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupAppointmentCount() {
        let leading = 10.f
        let width = 20.f
        appointmentCount.backgroundColor = .countColor
        appointmentCount.font = .mediumSystemFontOfSize(size: 14)
        appointmentCount.textColor = .white
        appointmentCount.textAlignment = .center
        appointmentCount.layer.cornerRadius = 10
        appointmentCount.clipsToBounds = true
        topView.addSubview(appointmentCount)
        
        appointmentCount.translatesAutoresizingMaskIntoConstraints = false
        appointmentCount.leadingAnchor.constraint(equalTo: appointmentLabel.trailingAnchor,
                                                  constant: leading).isActive = true
        appointmentCount.centerYAnchor.constraint(equalTo: appointmentImage.centerYAnchor).isActive = true
        appointmentCount.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupImportantImage() {
        let top = 10.f
        let leading = 10.f
        let size = 20.f
        let imageName = "Flag Icon"
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Missing ​​\(imageName) asset")
            return
        }
        importantImage.image = image
        topView.addSubview(importantImage)
        
        importantImage.translatesAutoresizingMaskIntoConstraints = false
        importantImage.topAnchor.constraint(equalTo: appointmentImage.bottomAnchor, constant: top).isActive = true
        importantImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: leading).isActive = true
        importantImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        importantImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupImportantLabel() {
        let leading = 10.f
        let width = 180.f
        importantLabel.font = .mediumSystemFontOfSize(size: 14)
        importantLabel.textColor = .white
        importantLabel.text = "Важные события:"
        importantLabel.textAlignment = .left
        topView.addSubview(importantLabel)
        
        importantLabel.translatesAutoresizingMaskIntoConstraints = false
        importantLabel.leadingAnchor.constraint(equalTo: importantImage.trailingAnchor,
                                                constant: leading).isActive = true
        importantLabel.centerYAnchor.constraint(equalTo: importantImage.centerYAnchor).isActive = true
        importantLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupImportantCount() {
        let leading = 10.f
        let width = 20.f
        importantCount.backgroundColor = .countColor
        importantCount.font = .mediumSystemFontOfSize(size: 14)
        importantCount.textColor = .white
        importantCount.textAlignment = .center
        importantCount.layer.cornerRadius = 10
        importantCount.clipsToBounds = true
        topView.addSubview(importantCount)
        
        importantCount.translatesAutoresizingMaskIntoConstraints = false
        importantCount.leadingAnchor.constraint(equalTo: importantLabel.trailingAnchor,
                                                constant: leading).isActive = true
        importantCount.centerYAnchor.constraint(equalTo: importantImage.centerYAnchor).isActive = true
        importantCount.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        addButton.layer.masksToBounds = false
        addButton.layer.shadowColor = UIColor.shadowColor.cgColor
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowRadius = 4
        addButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Private methods
    @objc private func refresh(_ sender: Any) {
        refreshBegin(refreshEnd: {() -> Void in
            self.tableView.refreshControl?.endRefreshing()
        })
    }
    
    private func refreshBegin(refreshEnd: @escaping () -> Void) {
        DispatchQueue.global().async {
            self.presenter?.getEvents(newDate: self.currentDate)
            DispatchQueue.main.async {
                refreshEnd()
            }
        }
    }
    
    func handleCellConfiguration(cell: JTACDayCell?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? DayCell else { return }
        let dayOfWeek = myCustomCell.dayOfWeekLabel.text
        
        if cellState.isSelected {
            myCustomCell.selectedView.isHidden = false
            myCustomCell.dateLabel.textColor = .white
            
            if dayOfWeek == "Сб" || dayOfWeek == "Вс" {
                myCustomCell.dayOfWeekLabel.textColor = .holidayColor
            } else {
                myCustomCell.dayOfWeekLabel.textColor = .black
            }
            
        } else {
            myCustomCell.selectedView.isHidden = true
            
            if dayOfWeek == "Сб" || dayOfWeek == "Вс" {
                myCustomCell.dateLabel.textColor = .holidayColor
                myCustomCell.dayOfWeekLabel.textColor = .holidayColor
            } else {
                myCustomCell.dateLabel.textColor = .black
                myCustomCell.dayOfWeekLabel.textColor = .black
            }
        }
        
    }
    
    // MARK: - Buttons methods
    @objc private func addButtonPressed() {
        presenter?.addButtonPressed()
    }
    
}

// MARK: - Table View Delegate
extension StartScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContact = UIContextualAction(style: .destructive,
                                               title: "") {  (_, _, completion) in
                                                self.presenter?.deleteEvent(index: indexPath.section)
                                                completion(true)
        }
        deleteContact.backgroundColor = .hdButtonColor
        deleteContact.image = UIImage(named: "Trash Icon")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContact])
        
        return swipeActions
    }
    
}

// MARK: - Table Data Source
extension StartScheduleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getCountEvents() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                       for: indexPath) as? EventCell
            else { return UITableViewCell() }
        cell.configure(startTime: presenter?.getStartTimeEvent(index: indexPath.section) ?? "",
                       endTime: presenter?.getEndTimeEvent(index: indexPath.section) ?? "",
                       event: presenter?.getTitleEvent(index: indexPath.section) ?? "",
                       eventColor: presenter?.getEventColor(index: indexPath.section) ?? .clear,
                       isMajor: presenter?.getMajorFlag(index: indexPath.section) ?? false)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(index: indexPath.section)
    }
    
}

extension StartScheduleViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = "2020 08 01".toDate(withFormat: "yyyy MM dd") ?? Date()
        let endDate = "2029 12 31".toDate(withFormat: "yyyy MM dd") ?? Date()
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: 1,
                                       calendar: Calendar.current,
                                       generateInDates: .off,
                                       generateOutDates: .off,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: false)
    }
    
}

extension StartScheduleViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView,
                  willDisplay cell: JTACDayCell,
                  forItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) {
        guard let myCustomCell = cell as? DayCell else { return }
        configureVisibleCell(myCustomCell: myCustomCell,
                             cellState: cellState,
                             date: date,
                             indexPath: indexPath)
    }
    
    func calendar(_ calendar: JTACMonthView,
                  cellForItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) -> JTACDayCell {
        guard let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "DayCell",
                                                              for: indexPath) as? DayCell else { return JTACDayCell() }
        configureVisibleCell(myCustomCell: myCustomCell,
                             cellState: cellState,
                             date: date,
                             indexPath: indexPath)
        return myCustomCell
    }
    
    func configureVisibleCell(myCustomCell: DayCell, cellState: CellState, date: Date, indexPath: IndexPath) {
        let dayOfWeek = presenter?.getCurrentDate(date: date)
        myCustomCell.dateLabel.text = cellState.text
        myCustomCell.dayOfWeekLabel.text = dayOfWeek
        
        if Calendar.current.isDateInToday(date) {
            myCustomCell.isSelected = true
            handleCellSelection(view: myCustomCell, cellState: cellState)
        } else {
            myCustomCell.isSelected = false
            handleCellSelection(view: myCustomCell, cellState: cellState)
        }
        
    }
    
    func calendar(_ calendar: JTACMonthView,
                  shouldSelectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTACMonthView,
                  didSelectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        presenter?.getEvents(newDate: date)
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView,
                  didDeselectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
}
