//
//  SelectYearPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 25.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SelectYearControllerDelegate: AnyObject {
    func callbackDate(newDate: String)
}

protocol SelectYearPresenterProtocol: Presenter {
    init(view: SelectYearViewController)
    func getCountDates() -> Int
    func getDateFromArray(_ index: Int) -> String
    func getCurrentDayOfWeek(date: Date) -> String
    func getCurrentDate(date: Date) -> String
    func setSelectDate()
    func saveDate(indexDate: Int?)
}

class SelectYearPresenter: SelectYearPresenterProtocol {
    
    // MARK: - Dependency
    let view: SelectYearViewController
    weak var delegate: SelectYearControllerDelegate?
    
    // MARK: - Constants and variables
    var selectedDate: String?
    private let yearsArray = ["1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959",
                              "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969",
                              "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979",
                              "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1999",
                              "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009",
                              "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019",
                              "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029"]
    
    // MARK: - Init
    required init(view: SelectYearViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func getCountDates() -> Int {
        return yearsArray.count
    }
    
    func getDateFromArray(_ index: Int) -> String {
        return yearsArray[index]
    }
    
    func getCurrentDayOfWeek(date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        var weekdayString = ""
        switch weekday {
        case 1:
            weekdayString = "Воскресенье"
        case 2:
            weekdayString = "Понедельник"
        case 3:
            weekdayString = "Вторник"
        case 4:
            weekdayString = "Среда"
        case 5:
            weekdayString = "Четверг"
        case 6:
            weekdayString = "Пятница"
        case 7:
            weekdayString = "Суббота"
        default:
            weekdayString = ""
        }
        return "\(weekdayString)"
    }
    
    func getCurrentDate(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "RU_ru")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func setSelectDate() {
        guard let selectedDate = selectedDate else { return }
        let index = yearsArray.firstIndex(where: { $0 == selectedDate })
        view.setSelectDate(IndexPath(row: index ?? 0, section: 0))
    }
    
    // MARK: - Coordinator
    func saveDate(indexDate: Int?) {
        guard let indexDate = indexDate else {
            view.showAlert(message: "Выберите год")
            return
        }
        view.dismiss(animated: true, completion: nil)
        let date = yearsArray[indexDate]
        delegate?.callbackDate(newDate: date)
    }
}

// MARK: - Presenter
extension SelectYearPresenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
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
