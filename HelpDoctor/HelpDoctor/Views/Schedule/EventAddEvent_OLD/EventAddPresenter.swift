//
//  EventAddPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

protocol EventAddPresenterProtocol: Presenter {
    init(view: EventAddViewController, eventType: EventType)
    func getEvent()
    func getStatusEvent() -> String
    func setIdEvent(idEvent: Int)
    func saveEvent(startDate: Date, endDate: Date, isMajor: Bool, title: String?, desc: String?, location: String?)
    func setNotifyDate(date: Date?)
    func convertStringToDate(date: String) -> Date?
    func deleteEvent()
    func otherNotifyTime(startDate: Date)
    func backToRoot()
    func getEventTitle() -> String
    func addMembersButtonPressed()
    func repeatNotifications()
    func setRepeat(repeatArray: [Int])
    func toMap()
}

class EventAddPresenter: EventAddPresenterProtocol {
    
    // MARK: - Dependency
    let view: EventAddViewController
    
    // MARK: - Constants and variables
    var idEvent: Int?
    var eventType: EventType
    var notifyDate: Date?
    var repeatArray: [Int] = []
    private let notification = NotificationDelegate()
    weak var delegate: SelectDateControllerDelegate?
    
    // MARK: - Init
    required init(view: EventAddViewController, eventType: EventType) {
        self.view = view
        self.eventType = eventType
    }
    
    // MARK: - Public methods
    func getEvent() {
        guard let idEvent = idEvent else { return }
        let getEvents = Schedule()
        getData(typeOfContent: .schedule_getEventsForCurrentId,
                returning: ([ScheduleEvents], Int?, String?).self,
                requestParams: ["event_id": String(idEvent)]) { [weak self] result in
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
    
    func saveEvent(startDate: Date, endDate: Date, isMajor: Bool, title: String?, desc: String?, location: String?) {
        if title == "" {
            view.showAlert(message: "Заполните название события")
            return
        }
        let currentEvent = ScheduleEvents(id: idEvent,
                                          start_date: convertDateToString(date: startDate),
                                          end_date: convertDateToString(date: endDate),
                                          notify_date: convertDateToString(date: notifyDate),
                                          title: title,
                                          description: desc,
                                          is_major: isMajor,
                                          event_place: location,
                                          event_type: eventType.rawValue)
        
        let createEvent = CreateOrUpdateEvent(events: currentEvent)
        getData(typeOfContent: .schedule_CreateOrUpdateEvent,
                returning: (Int?, String?).self,
                requestParams: ["json": createEvent.jsonData as Any] ) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            createEvent.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async {
                    print("createEvent = \(String(describing: createEvent.responce))")
                    guard let self = self,
                        let code = createEvent.responce?.0 else { return }
                    if responceCode(code: code) {
                        self.backToRoot()
                        self.delegate?.callback(newDate: startDate)
                        guard let title = title,
                            let notifyDate = self.notifyDate else { return }
                        for day in self.repeatArray {
                            self.notification.scheduleNotification(identifier: UUID().uuidString,
                                                                   title: self.getEventTitle(),
                                                                    body: desc,
                                                                    description: title,
                                                                    notifyDate: notifyDate,
                                                                    repeatDay: day)
                        }
                        
                    } else {
                        self.view.showAlert(message: createEvent.responce?.1)
                    }
                }
            }
        }
    }
    
    func setNotifyDate(date: Date?) {
        notifyDate = date
    }
    
    func getEventTitle() -> String {
        switch eventType {
        case .administrative:
            return "Административная деятельность"
        case .science:
            return "Научная деятельность"
        case .reception:
            return "Приём пациентов"
        case .other:
            return "Другое"
        }
    }
    
    func convertStringToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date)
    }
    
    func deleteEvent() {
        guard let idEvent = idEvent else { return }
        let resultDeleteEvents = Schedule()
        getData(typeOfContent: .schedule_deleteForCurrentEvent,
                returning: (Int?, String?).self,
                requestParams: ["event_id": String(idEvent)]) { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            resultDeleteEvents.responce = result
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    print("getEvents =\(String(describing: resultDeleteEvents.responce))")
                    guard let code = resultDeleteEvents.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.backToRoot()
                    } else {
                        self?.view.showAlert(message: resultDeleteEvents.responce?.1)
                    }
                }
            }
        }
    }
    
    func otherNotifyTime(startDate: Date) {
        let viewController = OtherTimeNotifyViewController()
        let presenter = OtherTimeNotifyPresenter(view: viewController, startTime: startDate)
        let delegate = self
        viewController.presenter = presenter
        viewController.delegate = delegate
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func repeatNotifications() {
        let viewController = RepeatNotificationsViewController()
        let presenter = RepeatNotificationsPresenter(view: viewController)
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setRepeat(repeatArray: [Int]) {
        self.repeatArray = repeatArray
        view.setReplyButtonChecked(isSelected: !repeatArray.isEmpty)
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
    
    func addMembersButtonPressed() {
        let viewController = AddMembersViewController()
        viewController.presenter = AddMembersPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toMap() {
        let viewController = LocationSearchViewController()
        let presenter = LocationSearchPresenter(view: viewController)
        viewController.delegate = self.view
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension EventAddPresenter: OtherTimeControllerDelegate {
    func callback(notifyDate: Date) {
        setNotifyDate(date: notifyDate)
    }
}
*/
