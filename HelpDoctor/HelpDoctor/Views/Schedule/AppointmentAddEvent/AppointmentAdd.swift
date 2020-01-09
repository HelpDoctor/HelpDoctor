//
//  AppointmentAdd.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 05.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AppointmentAddPresenterProtocol: Presenter {
    init(view: AppointmentAddViewController)
    func getEvent()
    func getStatusEvent() -> String
    func saveEvent(startDate: Date, endDate: Date, title: String?, desc: String?)
    func setIdEvent(idEvent: Int)
    func setNotifyDate(date: Date)
    func convertStringToDate(date: String) -> Date?
    func backToRoot()
}

class AppointmentAddPresenter: AppointmentAddPresenterProtocol {
    
    // MARK: - Constants and variables
    var view: AppointmentAddViewController
    var idEvent: Int?
    var startDate: Date?
    var finishDate: Date?
    var notifyDate: Date?
    var title: String?
    var desc: String?
    
    // MARK: - Init
    required init(view: AppointmentAddViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func getEvent() {
        guard let idEvent = idEvent else { return }
        let getEvents = Schedule()
        getData(typeOfContent: .schedule_getEventsForCurrentId,
                returning: ([ScheduleEvents], Int?, String?).self,
                requestParams: ["event_id": String(idEvent)])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            getEvents.events = result?.0
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("getEvents =\(String(describing: getEvents.events))")
                    guard let events = getEvents.events else { return }
                    self?.view.setEventOnView(event: events[0])
                }
            }
        }
    }
    
    func getStatusEvent() -> String {
        if idEvent == nil {
            return "Новое событие"
        }
        return "Редактирование события"
    }
    
    func setIdEvent(idEvent: Int) {
        self.idEvent = idEvent
    }
    
    func setNotifyDate(date: Date) {
        notifyDate = date
    }
    
    func saveEvent(startDate: Date, endDate: Date, title: String?, desc: String?) {
        guard let title = title else {
            view.showAlert(message: "Заполните имя пациента")
            return
        }
        let currentEvent = ScheduleEvents(id: idEvent,
                                          start_date: convertDateToString(date: startDate),
                                          end_date: convertDateToString(date: endDate),
                                          notify_date: convertDateToString(date: notifyDate),
                                          title: title,
                                          description: desc,
                                          is_major: false,
                                          event_place: "",
                                          event_type: "reception")
        print(currentEvent)
        let createEvent = CreateOrUpdateEvent(events: currentEvent)
        getData(typeOfContent: .schedule_CreateOrUpdateEvent,
                returning: (Int?, String?).self,
                requestParams: ["json": createEvent.jsonData as Any] )
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            createEvent.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("createEvent = \(String(describing: createEvent.responce))")
                    self?.backToRoot()
                }
            }
        }
    }
    
    func convertStringToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date)
    }
    
    // MARK: - Private methods
    private func convertDateToString(date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func backToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
    
    func save(source: SourceEditTextField) { }
    
}
