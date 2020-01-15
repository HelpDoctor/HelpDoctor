//
//  TabBarController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var activityIndicator = ActivityIndicatorView()
    var statusCheck = false
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.barTintColor = UIColor.tabBarColor
        profileCheck()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTabBarController() {
        let secondVc = StartScheduleViewController()
        secondVc.presenter = StartSchedulePresenter(view: secondVc)
        secondVc.tabBarItem = UITabBarItem(title: "Расписание", image: UIImage(named: "Schedule.pdf"), tag: 1)
        
        let thirdVc = StartMessagesViewController()
        thirdVc.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(named: "Messages.pdf"), tag: 2)
        
        let fourthVc = StartSettingsViewController()
        fourthVc.presenter = StartSettingsPresenter(view: fourthVc)
        fourthVc.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "Settings.pdf"), tag: 3)
        
        if statusCheck {
            let firstVc = ProfileViewController()
            firstVc.presenter = ProfilePresenter(view: firstVc)
            firstVc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "Main.pdf"), tag: 0)
            let controllerArray = [firstVc, secondVc, thirdVc, fourthVc]
            self.viewControllers = controllerArray.map { UINavigationController(rootViewController: $0) }
        } else {
            let firstVc = StartMainViewController()
            firstVc.presenter = StartMainPresenter(view: firstVc)
            firstVc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "Main.pdf"), tag: 0)
            let controllerArray = [firstVc, secondVc, thirdVc, fourthVc]
            self.viewControllers = controllerArray.map { UINavigationController(rootViewController: $0) }
        }
        
    }
    
    private func profileCheck() {
        activityIndicator.startAnimating()
        let checkProfile = Registration(email: nil, password: nil, token: myToken)
        
        getData(typeOfContent: .checkProfile,
                returning: (Int?, String?).self,
                requestParams: checkProfile.requestParams)
        { [weak self] result in
            let dispathGroup = DispatchGroup()
            checkProfile.responce = result
            
            dispathGroup.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    print("result=\(String(describing: checkProfile.responce))")
                    guard let code = checkProfile.responce?.0,
                        let status = checkProfile.responce?.1 else { return }
                    if responceCode(code: code) && status == "True" {
                        self?.statusCheck = true
                        self?.createTabBarController()
                    } else {
                        self?.statusCheck = false
                        self?.createTabBarController()
                    }
                }
            }
        }
    }
    
    func startAnimating() {
        activityIndicator = ActivityIndicatorView(frame: CGRect(x: (width - 70) / 2,
                                                                y: (height - 70) / 2,
                                                                width: 70,
                                                                height: 70))
        addBlurEffect()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        removeBlurEffect()
    }
    
}
