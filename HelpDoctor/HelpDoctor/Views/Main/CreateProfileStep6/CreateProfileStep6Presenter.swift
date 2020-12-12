//
//  CreateProfileStep6Presenter.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 29.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol CreateProfileStep6PresenterProtocol: Presenter {
    init(view: CreateProfileStep6ViewController)
    var isEdit: Bool { get }
    func convertDate(_ birthDate: String) -> String?
    func setUniversity(university: University)
    func universitySearch()
    func next()
    func dateChoice()
}

class CreateProfileStep6Presenter: CreateProfileStep6PresenterProtocol {
    
    // MARK: - Dependency
    let view: CreateProfileStep6ViewController
    private let transition = PanelTransition()
    
    // MARK: - Constants and variables
    var user: User?
    var isEdit = false
    var region: Regions?
    private var university: University?
    private var educationArray: [Education] = []
    
    // MARK: - Init
    required init(view: CreateProfileStep6ViewController) {
        self.view = view
        educationArray = Session.instance.education ?? []
    }
    
    // MARK: - Public methods
    /// Конвертация даты из формата yyy-MM-dd в формат dd.MM.yyyy
    /// - Parameter birthDate: дата в формте yyy-MM-dd
    /// - Returns: дата в формате dd.MM.yyyy
    func convertDate(_ birthDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale.current
        guard let birthday = dateFormatter.date(from: birthDate) else { return nil }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: birthday)
    }
    
    func setUniversity(university: University) {
        self.university = university
        view.setUniversity(university: university.educationName ?? "")
    }
    
    func universitySearch() {
        let viewController = UniversitiesViewController()
        let presenter = UniversitiesPresenter(view: viewController)
        viewController.presenter = presenter
        viewController.startActivityIndicator()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func updateEducation() {
        let educationId = Session.instance.education?[0].id ?? 0
        educationArray.removeAll()
        educationArray.append(Education(id: educationId,
                                        isMain: true,
                                        yearEnding: view.getDate(),
                                        academicDegree: view.getDegree(),
                                        education: university))
        
        NetworkManager.shared.updateUser(nil, nil, nil, nil, educationArray) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let controllers = self?.view.navigationController?.viewControllers else {
                        self?.back()
                        return
                    }
                    for viewControllers in controllers where viewControllers is ProfileViewController {
                        self?.view.navigationController?.popToViewController(viewControllers, animated: true)
                    }
                    for viewControllers in controllers where viewControllers is StartSettingsViewController {
                        self?.view.navigationController?.popToViewController(viewControllers,
                                                                             animated: true)
                    }
                case .failure(let error):
                    self?.view.showAlert(message: error.description)
                }
                self?.view.stopActivityIndicator()
            }
        }
    }
    
    // MARK: - Coordinator
    func next() {
        
        if isEdit {
            updateEducation()
        } else {
            educationArray.removeAll()
            educationArray.append(Education(id: 0,
                                            isMain: true,
                                            yearEnding: view.getDate(),
                                            academicDegree: view.getDegree(),
                                            education: university))
            
            let viewController = CreateProfileWorkViewController()
            let presenter = CreateProfileWorkPresenter(view: viewController)
            viewController.presenter = presenter
            presenter.user = user
            presenter.region = region
            presenter.educationArray = educationArray
            view.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func dateChoice() {
        let viewController = SelectYearViewController()
        let presenter = SelectYearPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        presenter.selectedDate = view.getDate()
        transition.frameOfPresentedViewInContainerView = CGRect(x: 0,
                                                                y: Session.height - 356,
                                                                width: view.view.bounds.width,
                                                                height: 356)
        viewController.transitioningDelegate = transition
        viewController.modalPresentationStyle = .custom
        view.present(viewController, animated: true)
    }
}

// MARK: - SelectYearControllerDelegate
extension CreateProfileStep6Presenter: SelectYearControllerDelegate {
    func callbackDate(newDate: String) {
        view.setDate(date: newDate)
    }
}

// MARK: - Presenter
extension CreateProfileStep6Presenter {
    func back() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func toProfile() { }
}
