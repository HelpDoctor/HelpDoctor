//
//  ViewEventPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

protocol ViewEventPresenterProtocol: Presenter {
    init(view: ViewEventViewController)
    func setIdEvent(idEvent: Int)
    func getEvent()
    func convertStringToDate(date: String) -> Date?
    func convertDate(date: String?) -> String?
    func saveEvent()
    func deleteEvent()
    func backToRoot()
}

class ViewEventPresenter: ViewEventPresenterProtocol {
    
    // MARK: - Constants and variables
    let view: ViewEventViewController
    var idEvent: Int?
    var eventType: String?
//    weak var delegate: SelectDateControllerDelegate?
    
    // MARK: - Init
    required init(view: ViewEventViewController) {
        self.view = view
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
                    self?.eventType = events[0].event_type
                    self?.view.setEventOnView(event: events[0])
                }
            }
        }
    }
    
    func setIdEvent(idEvent: Int) {
        self.idEvent = idEvent
    }
    
    func saveEvent() {
        switch eventType {
        case "reception":
//            let viewController = AppointmentAddViewController()
//            let presenter = AppointmentAddPresenter(view: viewController)
            let viewController = AddEventViewController()
            let presenter = AddEventPresenter(view: viewController)
            viewController.presenter = presenter
//            presenter.delegate = delegate
            presenter.setIdEvent(idEvent: idEvent ?? 0)
            view.navigationController?.pushViewController(viewController, animated: true)
        case "administrative":
//            let viewController = EventAddViewController()
//            let presenter = EventAddPresenter(view: viewController, eventType: .administrative)
            let viewController = AddEventViewController()
            let presenter = AddEventPresenter(view: viewController)
            viewController.presenter = presenter
//            presenter.delegate = delegate
            presenter.setIdEvent(idEvent: idEvent ?? 0)
            view.navigationController?.pushViewController(viewController, animated: true)
        case "scientific":
//            let viewController = EventAddViewController()
//            let presenter = EventAddPresenter(view: viewController, eventType: .science)
            let viewController = AddEventViewController()
            let presenter = AddEventPresenter(view: viewController)
            viewController.presenter = presenter
//            presenter.delegate = delegate
            presenter.setIdEvent(idEvent: idEvent ?? 0)
            view.navigationController?.pushViewController(viewController, animated: true)
        case "another":
//            let viewController = EventAddViewController()
//            let presenter = EventAddPresenter(view: viewController, eventType: .other)
            let viewController = AddEventViewController()
            let presenter = AddEventPresenter(view: viewController)
            viewController.presenter = presenter
//            presenter.delegate = delegate
            presenter.setIdEvent(idEvent: idEvent ?? 0)
            view.navigationController?.pushViewController(viewController, animated: true)
        default:
            view.showAlert(message: "Не верный тип события")
        }
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
//                        self?.delegate?.callback(newDate: Date())
                    } else {
                        self?.view.showAlert(message: resultDeleteEvents.responce?.1)
                    }
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
    
    func convertDate(date: String?) -> String? {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        guard let dateDate = dateFormatter.date(from: date) else { return nil }
        dateFormatter.dateFormat = "dd/MM/yyyy   HH:mm"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: dateDate)
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func backToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
    
}
*/
