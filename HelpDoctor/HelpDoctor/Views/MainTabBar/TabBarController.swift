//
//  TabBarController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let session = Session.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.barTintColor = UIColor.newTabBarColor
        createTabBarController()
        getStatusUser()
        getUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTabBarController() {
        
        let firstVc = StartScheduleViewController()
        firstVc.presenter = StartSchedulePresenter(view: firstVc)
        firstVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ScheduleTabBarIcon"), tag: 0)
        
        let secondVc = ContactsViewController()
        secondVc.presenter = ContactsPresenter(view: secondVc)
        secondVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ContactsTabBarIcon"), tag: 1)
        
        let thirdVc = StartMessagesViewController()
//        let thirdVc = StartMainViewController()
        thirdVc.presenter = StartMessagesPresenter(view: thirdVc)
        thirdVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "MessageTabBarIcon"), tag: 2)
        
        let fourthVc = StartSearchViewController()
        fourthVc.presenter = StartSearchPresenter(view: fourthVc)
        fourthVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SearchTabBarIcon"), tag: 3)
        
        let fifthVc = StartSettingsViewController()
        fifthVc.presenter = StartSettingsPresenter(view: fifthVc)
        fifthVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SettingsTabBarIcon"), tag: 4)
        
        let controllerArray = [firstVc, secondVc, thirdVc, fourthVc, fifthVc]
        self.viewControllers = controllerArray.map { UINavigationController(rootViewController: $0) }
    }
    
    private func getStatusUser() {
        NetworkManager.shared.getUserStatus { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let networkResponse):
                    let status = networkResponse.status
                    switch status {
                    case "denied":
                        UserDefaults.standard.set("denied", forKey: "userStatus")
                        self?.toErrorVerification(networkResponse.message)
                    case "not_verification":
                        UserDefaults.standard.set("not_verification", forKey: "userStatus")
                        self?.toVerification()
                    case "processing":
                        UserDefaults.standard.set("processing", forKey: "userStatus")
                        self?.toEndVerification()
                    case "verified":
                        if UserDefaults.standard.string(forKey: "userStatus") != "verified" {
                            self?.toOkVerification()
                        }
                        UserDefaults.standard.set("verified", forKey: "userStatus")
                    default:
                        break
                    }
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
    
    private func getUser() {
        NetworkManager.shared.getUser { [weak self] result in
            switch result {
            case .success(let profiles):
                self?.session.user = profiles.user
                self?.session.education = profiles.educations
                self?.session.userJob = profiles.job
                self?.session.specialization = profiles.specializations
            case .failure(let error):
                self?.showAlert(message: error.description)
            }
        }
    }
    
    func toVerification() {
        let viewController = VerificationViewController()
        viewController.presenter = VerificationPresenter(view: viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    func toEndVerification() {
        let viewController = VerificationEndViewController()
        viewController.presenter = VerificationEndPresenter(view: viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    func toErrorVerification(_ message: String?) {
        let viewController = VerificationErrorViewController()
        viewController.presenter = VerificationErrorPresenter(view: viewController)
        viewController.messageFromServer = message
        present(viewController, animated: true, completion: nil)
    }
    
    func toOkVerification() {
        let viewController = VerificationOkViewController()
        viewController.presenter = VerificationOkPresenter(view: viewController)
        present(viewController, animated: true, completion: nil)
    }
}
