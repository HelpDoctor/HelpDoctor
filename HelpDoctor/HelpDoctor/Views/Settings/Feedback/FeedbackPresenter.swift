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
        guard let text = feedback else { return }
        if text == "" || text == "Введите, пожалуйста, своё сообщение (максимально 300 символов)" {
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
        NetworkManager.shared.feedback(text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.view.clearTextFields()
                    self?.view.showSaved(message: "Отзыв отправлен")
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - Coordinator
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
