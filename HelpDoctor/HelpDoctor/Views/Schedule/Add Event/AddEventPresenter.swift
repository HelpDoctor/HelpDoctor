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
    func getEvent()
    func setIdEvent(idEvent: Int)
    func convertDate(date: String?) -> String?
}

class AddEventPresenter: AddEventPresenterProtocol, StartAddEventControllerDelegate {
    
    let view: AddEventViewController
    private let transition = PanelTransition()
    var idEvent: Int?
    private var startDate: Date?
    private var endDate: Date?
    
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
//                    self?.eventType = events[0].event_type
                    self?.view.setEventOnView(event: events[0])
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
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - StartAddEventControllerDelegate
    func callback(eventType: EventType) {
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
