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
    func getCountContacts() -> Int
    func getContact(index: Int) -> Contacts?
    func setGuestList(guests: [Contacts])
    func saveEvent(isMajor: Bool, title: String?, location: String?)
    func deleteEvent()
    func setIdEvent(idEvent: Int)
    func convertDate(date: String?) -> String?
    func toMap()
    func toAddGuests()
}

class AddEventPresenter: AddEventPresenterProtocol {
    
    let view: AddEventViewController
    private let notification = NotificationDelegate()
    private let transition = PanelTransition()
    private var idEvent: Int?
    private var eventType: EventType?
    private var startDate: Date?
    private var endDate: Date?
    private var notifyDate: Date?
    private var guestList: [Contacts] = []
    
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
        presenter.selectedDate = isStart ? startDate : endDate
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
        NetworkManager.shared.getEventForId(idEvent) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let event):
                    self?.eventType = event.eventType
                    self?.startDate = event.startDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.endDate = event.endDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.notifyDate = event.notifyDate?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                    self?.createGuestList(participants: event.participants ?? [])
                    self?.view.setEventOnView(event: event)
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    private func createGuestList(participants: [Event.Participant]) {
        for guest in participants {
            guestList.append(Contacts(id: guest.id,
                                      firstName: guest.fullName,
                                      middleName: nil,
                                      lastName: nil,
                                      foto: nil,
                                      specialization: nil))
        }
        view.reloadCollectionView()
    }
    
    func getCountContacts() -> Int {
        return guestList.count
    }
    
    func getContact(index: Int) -> Contacts? {
        return guestList[index]
    }
    
    func setGuestList(guests: [Contacts]) {
        guestList = guests
        view.reloadCollectionView()
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
        var participants: [Event.Participant] = []
        guestList.forEach {
            participants.append(Event.Participant(id: $0.id, fullName: $0.fullName))
        }

        let newEvent = Event(id: idEvent,
                             startDate: startDate.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                             endDate: endDate.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                             notifyDate: notifyDate?.toString(withFormat: "yyyy-MM-dd HH:mm:ss"),
                             title: title,
                             description: nil,
                             isMajor: isMajor,
                             eventPlace: location,
                             eventType: eventType,
                             participants: participants)
        NetworkManager.shared.setEvent(newEvent) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.back()
                    guard let idEvent = self?.idEvent,
                          let notifyDate = self?.notifyDate else { return }
                    self?.notification.scheduleNotification(identifier: idEvent,
                                                            title: eventType.description,
                                                            body: nil,
                                                            description: title,
                                                            notifyDate: notifyDate,
                                                            repeatDay: nil)
                    
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
            }
        }
    }
    
    func deleteEvent() {
        guard let idEvent = idEvent else { return }
        NetworkManager.shared.deleteEent(idEvent) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.back()
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
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
        viewController.presenter?.setSelectedContact(guestList)
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

// MARK: - SelectDateControllerDelegate
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

// MARK: - RepeatEventControllerDelegate
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

// MARK: - SelectRepeatTimeControllerDelegate
extension AddEventPresenter: SelectRepeatTimeControllerDelegate {
    func callbackNoTime() {
        view.setNeverRepeat()
    }
    
    func callbackTime() {
        view.setRepeatLabel(repeatText: "Польз. настройки")
    }
}

// MARK: - SelectNotifyControllerDelegate
extension AddEventPresenter: SelectNotifyControllerDelegate {
    func callback(notifyTime: Double) {
        view.setNotifyTime(notifyTime: "Уведомить за \(Int(notifyTime)) минут")
        guard let startDate = startDate else { return }
        notifyDate = startDate - (60 * notifyTime)
    }
}
