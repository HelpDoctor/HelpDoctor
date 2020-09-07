//
//  AddEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 20.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol AddEventPresenterProtocol: Presenter {
    init(view: AddEventViewController)
    func eventTypeChoice()
    func dateChoice(isStart: Bool)
    func repeatChoice()
    func notifyChoice()
    func getEvent()
    func saveEvent(isMajor: Bool, title: String?, location: String?)
    func setIdEvent(idEvent: Int)
    func convertDate(date: String?) -> String?
    func toMap()
    func toAddGuests()
}

class AddEventPresenter: AddEventPresenterProtocol {
    
    let view: AddEventViewController
    private let transition = PanelTransition()
    private var idEvent: Int?
    private var eventType: EventType?
    private var startDate: Date?
    private var endDate: Date?
    private var notifyDate: Date?
    
    // MARK: - Init
    required init(view: AddEventViewController) {
        self.view = view
    }
    
    func eventTypeChoice() {
        let viewController = StartAddEventViewController()
        let presenter = StartAddEventPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        transition.frameOfPresentedViewInContainerView = CGRect(x: 0,
                                                                y: Session.height - 356,
                                                                width: view.view.bounds.width,
                                                                height: 356)
        viewController.transitioningDelegate = transition
        viewController.modalPresentationStyle = .custom
        view.present(viewController, animated: true)
    }
    
    func dateChoice(isStart: Bool) {
        let viewController = SelectDateViewController()
        var fromDate = Date()
        if !isStart {
            fromDate = startDate ?? Date()
        }
        let presenter = SelectDatePresenter(view: viewController, startDate: fromDate, isStart: isStart)
        viewController.presenter = presenter
        presenter.delegate = self
        transition.frameOfPresentedViewInContainerView = CGRect(x: 0,
                                                                y: Session.height - 356,
                                                                width: view.view.bounds.width,
                                                                height: 356)
        viewController.transitioningDelegate = transition
        viewController.modalPresentationStyle = .custom
        view.present(viewController, animated: true)
    }
    
    func repeatChoice() {
        let viewController = RepeatEventViewController()
        let presenter = RepeatEventPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        transition.frameOfPresentedViewInContainerView = CGRect(x: 0,
                                                                y: Session.height - 356,
                                                                width: view.view.bounds.width,
                                                                height: 356)
        viewController.transitioningDelegate = transition
        viewController.modalPresentationStyle = .custom
        view.present(viewController, animated: true)
    }
    
    func notifyChoice() {
        guard startDate != nil else {
            view.showAlert(message: "Сначала заполните время начала события")
            return
        }
        let viewController = SelectNotifyViewController()
        let presenter = SelectNotifyPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        transition.frameOfPresentedViewInContainerView = CGRect(x: 0,
                                                                y: Session.height - 356,
                                                                width: view.view.bounds.width,
                                                                height: 356)
        viewController.transitioningDelegate = transition
        viewController.modalPresentationStyle = .custom
        view.present(viewController, animated: true)
    }
    
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
                    self?.setEventType(events[0].event_type)
                    self?.startDate = events[0].start_date.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.endDate = events[0].end_date.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.notifyDate = events[0].notify_date?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.view.setEventOnView(event: events[0])
                }
            }
        }
    }
    
    private func setEventType(_ eventTypeString: String) {
        switch eventTypeString {
        case "reception":
            eventType = .reception
        case "administrative":
            eventType = .administrative
        case "scientific":
            eventType = .science
        case "another":
            eventType = .other
        default:
            eventType = nil
        }
    }
    
    func saveEvent(isMajor: Bool, title: String?, location: String?) {
        if title == "" {
            view.showAlert(message: "Заполните название события")
            return
        }
        guard let startDate = startDate else {
            view.showAlert(message: "Укажите дату начала события")
            return
        }
        guard let endDate = endDate else {
            view.showAlert(message: "Укажите дату окончания события")
            return
        }
        guard let eventType = eventType else {
            view.showAlert(message: "Выберите тип события")
            return
        }
        let currentEvent = ScheduleEvents(id: idEvent,
                                          start_date: startDate.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                                          end_date: endDate.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                                          notify_date: notifyDate?.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                                          title: title,
                                          description: nil,
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
                        self.back()
//                        self.delegate?.callback(newDate: startDate)
//                        guard let title = title,
//                            let notifyDate = self.notifyDate else { return }
//                        for day in self.repeatArray {
//                            self.notification.scheduleNotification(identifier: UUID().uuidString,
//                                                                   title: self.getEventTitle(),
//                                                                    body: desc,
//                                                                    description: title,
//                                                                    notifyDate: notifyDate,
//                                                                    repeatDay: day)
//                        }
                        
                    } else {
                        self.view.showAlert(message: createEvent.responce?.1)
                    }
                }
            }
        }
    }
    
    func setIdEvent(idEvent: Int) {
        self.idEvent = idEvent
    }
    
    func convertDate(date: String?) -> String? {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        guard let dateDate = dateFormatter.date(from: date) else { return nil }
        dateFormatter.dateFormat = "dd/MM HH:mm"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: dateDate)
    }
    
    func toMap() {
        let viewController = LocationSearchViewController()
        let presenter = LocationSearchPresenter(view: viewController)
        viewController.delegate = self.view
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toAddGuests() {
        let viewController = AddGuestsViewController()
        viewController.presenter = AddGuestsPresenter(view: viewController)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}

extension AddEventPresenter: StartAddEventControllerDelegate {
    
    func callback(eventType: EventType) {
        self.eventType = eventType
        switch eventType {
        case .administrative:
            view.setEventType(eventType: "Административная деятельность", color: .administrativeEventColor)
        case .other:
            view.setEventType(eventType: "Другое", color: .anotherEventColor)
        case .reception:
            view.setEventType(eventType: "Прием пациентов", color: .receptionEventColor)
        case .science:
            view.setEventType(eventType: "Научная деятельность", color: .scientificEventColor)
        }
    }
    
}

extension AddEventPresenter: SelectDateControllerDelegate {
    
    func callbackStartDate(newDate: String) {
        view.setStartDate(startDate: convertDate(date: newDate) ?? "")
        startDate = newDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    func callbackEndDate(newDate: String) {
        view.setEndDate(endDate: convertDate(date: newDate) ?? "")
        endDate = newDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
}

extension AddEventPresenter: RepeatEventControllerDelegate {
    
    func callbackDayRepeat() {
        view.setRepeatLabel(repeatText: "Каждый день")
    }
    
    func callbackWeekRepeat() {
        view.setRepeatLabel(repeatText: "Каждую неделю")
    }
    
    func callbackMonthRepeat() {
        view.setRepeatLabel(repeatText: "Каждый месяц")
    }
    
    func callbackYearRepeat() {
        view.setRepeatLabel(repeatText: "Каждый год")
    }
    
    func callbackNeverRepeat() {
        view.setNeverRepeat()
    }
    
    func callbackTimeRepeat() {
        let viewController = SelectRepeatTimeViewController()
        let presenter = SelectRepeatTimePresenter(view: viewController)
        presenter.delegate = self
        viewController.presenter = presenter
        view.navigationController?.pushViewController(viewController, animated: false)
    }
    
}

extension AddEventPresenter: SelectRepeatTimeControllerDelegate {
    
    func callbackNoTime() {
        view.setNeverRepeat()
    }
    
    func callbackTime() {
        view.setRepeatLabel(repeatText: "Польз. настройки")
    }
    
}

extension AddEventPresenter: SelectNotifyControllerDelegate {
    
    func callback(notifyTime: Double) {
        view.setNotifyTime(notifyTime: "Уведомить за \(Int(notifyTime)) минут")
        guard let startDate = startDate else { return }
        notifyDate = startDate - (60 * notifyTime)
    }
    
}
