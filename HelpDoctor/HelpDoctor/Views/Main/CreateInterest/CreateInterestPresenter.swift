//
//  CreateInterestPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateInterestPresenterDelegate: AnyObject {
    func callback(interests: [ListOfInterests])
}

protocol CreateInterestPresenterProtocol {
    init(view: CreateInterestViewController)
    func createInterest(interest: String?)
    func back()
}

class CreateInterestPresenter: CreateInterestPresenterProtocol {
    
    let view: CreateInterestViewController
    weak var delegate: CreateInterestPresenterDelegate?
    
    required init(view: CreateInterestViewController) {
        self.view = view
    }
    
    func createInterest(interest: String?) {
        guard let interest = interest else {
            view.showAlert(message: "Заполните поле интереса")
            return
        }
        view.startActivityIndicator()
        let addInterest = Profile()
        getData(typeOfContent: .addProfileInterest,
                returning: ([ListOfInterests], Int?, String?).self,
                requestParams: ["interest": interest])
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            
            addInterest.addInterests = result?.0
            addInterest.responce = (result?.1, result?.2)
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("addInterestResponce = \(String(describing: addInterest.responce))")
                    print("addInterest \(String(describing: addInterest.addInterests))")
                    guard let code = addInterest.responce?.0 else { return }
                    if responceCode(code: code) {
                        self?.delegate?.callback(interests: addInterest.addInterests ?? [])
                        self?.back()
                    } else {
                        self?.view.showAlert(message: addInterest.responce?.1)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
