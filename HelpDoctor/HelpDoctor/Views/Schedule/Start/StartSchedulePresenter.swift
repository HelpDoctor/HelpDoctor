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
    func getCountPatients() -> Int?
    func getCountMajorEvents() -> Int?
    func getStartTimeEvent(index: Int) -> String?
    func getEndTimeEvent(index: Int) -> String?
    func getEventColor(index: Int) -> UIColor?
    func getMajorFlag(index: Int) -> Bool?
    func getTitleEvent(index: Int) -> String?
//    func selectDate()
}

class StartSchedulePresenter: StartSchedulePresenterProtocol {
    
    let view: StartScheduleViewController
    private var arrayEvents: [ScheduleEvents]?
    
    // MARK: - Init
    required init(view: StartScheduleViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func didSelectRow(index: Int) {
        let viewController = ViewEventViewController()
        let presenter = ViewEventPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        presenter.setIdEvent(idEvent: arrayEvents?[index].id ?? 0)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addButtonPressed() {
        let viewController = AddEventViewController()
        let presenter = AddEventPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getEvents(newDate: Date) {
        let getEvents = Schedule()
        let anyDate = convertDate(date: newDate)
        getData(typeOfContent: .schedule_getEventsForCurrentDate,
                returning: ([ScheduleEvents], Int?, String?).self,
                requestParams: ["AnyDate": anyDate]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            getEvents.events = result?.0
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    print("getEvents =\(String(describing: getEvents.events))")
                    self?.view.setDate(date: newDate)
                    self?.arrayEvents = []
                    self?.arrayEvents = getEvents.events
                    self?.view.reloadTableView()
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
        let dateString = dateFormatter.string(from: date)
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
    
    func getCountPatients() -> Int? {
        let filteredArray = arrayEvents?.filter { (event: ScheduleEvents) -> Bool in
            return event.event_type == "reception"
        }
        return filteredArray?.count
    }
    
    func getCountMajorEvents() -> Int? {
        let filteredArray = arrayEvents?.filter { (event: ScheduleEvents) -> Bool in
            return event.is_major == true
        }
        return filteredArray?.count
    }
    
    func getStartTimeEvent(index: Int) -> String? {
        guard let startDate = arrayEvents?[index].start_date else { return nil }
        return "\(startDate[11 ..< 16])"
    }
    
    func getEndTimeEvent(index: Int) -> String? {
        guard let endDate = arrayEvents?[index].end_date else { return nil }
        return "\(endDate[11 ..< 16])"
    }
    
    func getEventColor(index: Int) -> UIColor? {
        guard let eventType = arrayEvents?[index].event_type else { return nil }
        switch eventType {
        case "reception":
            return .receptionEventColor
        case "administrative":
            return .administrativeEventColor
        case "scientific":
            return .scientificEventColor
        case "another":
            return .anotherEventColor
        default:
            return .clear
        }
    }
    
    func getMajorFlag(index: Int) -> Bool? {
        return arrayEvents?[index].is_major
    }
    
    func getTitleEvent(index: Int) -> String? {
        guard let title = arrayEvents?[index].title else { return nil }
        if arrayEvents?[index].event_type == "reception" {
            return "Прием пациента: \n\(title)"
        } else {
            return title
        }
    }
    /*
    func selectDate() {
        let viewController = SelectDateViewController()
        let presenter = SelectDatePresenter(view: viewController, startDate: view.getDate())
        let delegate = self
        viewController.presenter = presenter
        viewController.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    */
    // MARK: - PresenterProtocol
    func back() { }
    
}

extension StartSchedulePresenter: SelectDateControllerDelegate {
    
    func callback(newDate: Date) {
        getEvents(newDate: newDate)
    }
    
    func convertDate(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

