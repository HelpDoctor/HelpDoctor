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
    func callbackTime()
}

protocol SelectRepeatTimePresenterProtocol: Presenter {
    init(view: SelectRepeatTimeViewController)
    func getHoursFromArray(_ index: Int) -> Int
    func getMinutesFromArray(_ index: Int) -> String
    func saveDate(indexHours: Int?, indexMinutes: Int?)
}

class SelectRepeatTimePresenter: SelectRepeatTimePresenterProtocol {
    
    // MARK: - Dependency
    let view: SelectRepeatTimeViewController
    weak var delegate: SelectRepeatTimeControllerDelegate?
    
    // MARK: - Constants and variables
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
    func getHoursFromArray(_ index: Int) -> Int {
        return hoursArray[index]
    }
    
    func getMinutesFromArray(_ index: Int) -> String {
        return minutesArray[index]
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
        delegate?.callbackNoTime()
    }
    
    func saveDate(indexHours: Int?, indexMinutes: Int?) {
        guard indexHours != nil else {
            view.showAlert(message: "Выберите час")
            return
        }
        guard indexMinutes != nil else {
            view.showAlert(message: "Выберите минуту")
            return
        }
        view.navigationController?.popViewController(animated: true)
        delegate?.callbackTime()
    }
    
}
