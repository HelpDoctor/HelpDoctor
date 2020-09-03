//
//  SelectRepeatTimePresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 03.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol SelectRepeatTimeControllerDelegate: AnyObject {
    func callbackNoTime()
//    func callbackStartDate(newDate: String)
//    func callbackEndDate(newDate: String)
}

protocol SelectRepeatTimePresenterProtocol: Presenter {
    init(view: SelectRepeatTimeViewController)
    func getCountDates() -> Int
    func getDateFromArray(_ index: Int) -> Date
    func getHoursFromArray(_ index: Int) -> Int
    func getMinutesFromArray(_ index: Int) -> String
    func selectTodayRow() -> Int
    func getCurrentDayOfWeek(date: Date) -> String
    func getCurrentDate(date: Date) -> String
    func saveDate(indexDate: Int?, indexHours: Int?, indexMinutes: Int?)
}

class SelectRepeatTimePresenter: SelectRepeatTimePresenterProtocol {
    
    // MARK: - Dependency
    let view: SelectRepeatTimeViewController
    weak var delegate: SelectRepeatTimeControllerDelegate?
    
    // MARK: - Constants and variables
//    var startDate: Date
//    var isStart: Bool
    private var datesArray: [Date] = []
    private let hoursArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    private let minutesArray = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11",
                                "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35",
                                "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47",
                                "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    // MARK: - Init
    required init(view: SelectRepeatTimeViewController) {
        self.view = view
    }
    
    // MARK: - Public methods
    func getCountDates() -> Int {
        return datesArray.count
    }
    
    func getDateFromArray(_ index: Int) -> Date {
        return datesArray[index]
    }
    
    func getHoursFromArray(_ index: Int) -> Int {
        return hoursArray[index]
    }
    
    func getMinutesFromArray(_ index: Int) -> String {
        return minutesArray[index]
    }
    
    func selectTodayRow() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let today = formatter.string(from: Date())
        return datesArray.firstIndex(of: formatter.date(from: today)!) ?? 0
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
    
    private func generateDateRange(fromDate: String = "2020 01 01", toDate: String = "2030 12 31") -> [Date] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        guard let startDate = formatter.date(from: fromDate),
            let endDate = formatter.date(from: toDate) else { return [] }
        let calendar = Calendar.autoupdatingCurrent
        if startDate > endDate { return [] }
        var returnDates: [Date] = []
        var currentDate = startDate
        repeat {
            returnDates.append(currentDate)
            currentDate = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: currentDate)!)
        } while currentDate <= endDate
        return returnDates
    }

    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
        delegate?.callbackNoTime()
    }
    
    func saveDate(indexDate: Int?, indexHours: Int?, indexMinutes: Int?) {
        guard let indexDate = indexDate else {
            view.showAlert(message: "Выберите день")
            return
        }
        guard let indexHours = indexHours else {
            view.showAlert(message: "Выберите час")
            return
        }
        guard let indexMinutes = indexMinutes else {
            view.showAlert(message: "Выберите минуту")
            return
        }
        view.dismiss(animated: true, completion: nil)
        let date = datesArray[indexDate]
        let hours = hoursArray[indexHours]
        let minutes = minutesArray[indexMinutes]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        let newDate = "\(dateString) \(hours):\(minutes):00"
//        if isStart {
//            delegate?.callbackStartDate(newDate: newDate)
//        } else {
//            delegate?.callbackEndDate(newDate: newDate)
//        }
    }
    
}

