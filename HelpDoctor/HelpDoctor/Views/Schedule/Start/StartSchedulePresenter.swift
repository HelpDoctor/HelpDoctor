//
//  StartSchedulePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol StartSchedulePresenterProtocol: Presenter {
    init(view: StartScheduleViewController)
    func didSelectRow(index: Int)
    func addButtonPressed()
    func getEvents(newDate: Date)
    func getCountEvents() -> Int?
    func getCurrentDate(date: Date) -> String
    func getCurrentMonth(date: Date) -> String
    func getCountPatients() -> Int?
    func getCountMajorEvents() -> Int?
    func getStartTimeEvent(index: Int) -> String?
    func getEndTimeEvent(index: Int) -> String?
    func getEventColor(index: Int) -> UIColor?
    func getMajorFlag(index: Int) -> Bool?
    func getTitleEvent(index: Int) -> String?
    func deleteEvent(index: Int)
    func getEvents()
}

class StartSchedulePresenter: StartSchedulePresenterProtocol {
    
    let view: StartScheduleViewController
    private var arrayEvents: [Event]?
    
    // MARK: - Init
    required init(view: StartScheduleViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func didSelectRow(index: Int) {
//        let viewController = ViewEventViewController()
//        let presenter = ViewEventPresenter(view: viewController)
        let viewController = AddEventViewController()
        let presenter = AddEventPresenter(view: viewController)
        viewController.presenter = presenter
//        presenter.delegate = self
        presenter.setIdEvent(idEvent: arrayEvents?[index].id ?? 0)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addButtonPressed() {
        let viewController = AddEventViewController()
        let presenter = AddEventPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getEvents(newDate: Date) {
        let anyDate = newDate.toString(withFormat: "yyyy-MM-dd")
        NetworkManager.shared.getEventForDate(anyDate) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.view.setDate(date: newDate)
                    self?.arrayEvents = []
                    self?.arrayEvents = events
                    self?.view.reloadTableView()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func getCountEvents() -> Int? {
        return arrayEvents?.count
    }
    
    func getCurrentDate(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        var weekdayString = ""
        switch weekday {
        case 1:
            weekdayString = "Вс"
        case 2:
            weekdayString = "Пн"
        case 3:
            weekdayString = "Вт"
        case 4:
            weekdayString = "Ср"
        case 5:
            weekdayString = "Чт"
        case 6:
            weekdayString = "Пт"
        case 7:
            weekdayString = "Сб"
        default:
            weekdayString = ""
        }
        return "\(weekdayString)"
    }
    
    func getCurrentMonth(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        var monthString = ""
        switch month {
        case 1:
            monthString = "Янв"
        case 2:
            monthString = "Фев"
        case 3:
            monthString = "Мар"
        case 4:
            monthString = "Апр"
        case 5:
            monthString = "Май"
        case 6:
            monthString = "Июн"
        case 7:
            monthString = "Июл"
        case 8:
            monthString = "Авг"
        case 9:
            monthString = "Сен"
        case 10:
            monthString = "Окт"
        case 11:
            monthString = "Ноя"
        case 12:
            monthString = "Дек"
        default:
            monthString = ""
        }
        return "\(monthString)"
    }
    
    func getCountPatients() -> Int? {
        let filteredArray = arrayEvents?.filter { (event: Event) -> Bool in
            return event.eventType?.rawValue == "reception"
        }
        return filteredArray?.count
    }
    
    func getCountMajorEvents() -> Int? {
        let filteredArray = arrayEvents?.filter { (event: Event) -> Bool in
            return event.isMajor == true
        }
        return filteredArray?.count
    }
    
    func getStartTimeEvent(index: Int) -> String? {
        guard let startDate = arrayEvents?[index].startDate else { return nil }
        return "\(startDate[11 ..< 16])"
    }
    
    func getEndTimeEvent(index: Int) -> String? {
        guard let endDate = arrayEvents?[index].endDate else { return nil }
        return "\(endDate[11 ..< 16])"
    }
    
    func getEventColor(index: Int) -> UIColor? {
        guard let eventType = arrayEvents?[index].eventType else { return nil }
        switch eventType {
        case .reception:
            return .receptionEventColor
        case .administrative:
            return .administrativeEventColor
        case .science:
            return .scientificEventColor
        case .other:
            return .anotherEventColor
        }
    }
    
    func getMajorFlag(index: Int) -> Bool? {
        return arrayEvents?[index].isMajor
    }
    
    func getTitleEvent(index: Int) -> String? {
        guard let title = arrayEvents?[index].title else { return nil }
        if arrayEvents?[index].eventType?.rawValue == "reception" {
            return "Прием пациента: \n\(title)"
        } else {
            return title
        }
    }
    
    func deleteEvent(index: Int) {
        guard let idEvent = arrayEvents?[index].id else { return }
        NetworkManager.shared.deleteEent(idEvent) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let newDate = self?.view.getDate() else { return }
                    self?.getEvents(newDate: newDate)
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func getEvents() {
        NetworkManager.shared.getEvents(from: "2021-01-01", to: "2029-12-31") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let eventsForDate):
                    Session.instance.eventDates = eventsForDate.filter { $0.isEvent }.map { $0.date }
                    self?.view.reloadCalendar()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
}

// MARK: - Presenter
extension StartSchedulePresenter {
    func back() { }
    
    func toProfile() {
        if Session.instance.userCheck {
            let viewController = ProfileViewController()
            viewController.presenter = ProfilePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = CreateProfileNameViewController()
            viewController.presenter = CreateProfileNamePresenter(view: viewController)
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
