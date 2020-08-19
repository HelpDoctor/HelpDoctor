//
//  FeedbackPresenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 23.02.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol FeedbackPresenterProtocol: Presenter {
    init(view: FeedbackViewController)
    func sendFeedback(feedback: String?)
}

class FeedbackPresenter: FeedbackPresenterProtocol {
    
    var view: FeedbackViewController
    
    required init(view: FeedbackViewController) {
        self.view = view
    }
    
    func sendFeedback(feedback: String?) {
        guard let text = feedback else {
            view.showAlert(message: "Отзыв не может быть пустым")
            return
        }
        
        if text.count > 300 {
            view.showAlert(message:
                """
                Превышено допустимое кол-во символов ввода. Попробуйте рассказать о своей проблеме короче
                """
            )
            return
        }
        
        view.startActivityIndicator()
        let sendFeedback = Feedback(text: text)
        
        getData(typeOfContent: .feedback,
                returning: (Int?, String?).self,
                requestParams: sendFeedback.requestParams) { [weak self] result in
            let dispathGroup = DispatchGroup()
            sendFeedback.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self]  in
                    print("result= \(String(describing: sendFeedback.responce))")
                    let code = sendFeedback.responce?.0
                    switch code {
                    case 200:
                        self?.view.clearTextFields()
                        self?.view.showSaved(message: "Отзыв отправлен")
                    default:
                        self?.view.showAlert(message: sendFeedback.responce?.1)
                    }
                    self?.view.stopActivityIndicator()
                }
            }
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
