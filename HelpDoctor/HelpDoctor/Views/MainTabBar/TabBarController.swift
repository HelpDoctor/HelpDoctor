//
//  TabBarController.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 02.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.barTintColor = UIColor.tabBarColor
        createTabBarController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTabBarController() {
        
        let firstVc = StartMainViewController()
        firstVc.presenter = StartMainPresenter(view: firstVc)
        firstVc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "Main.pdf"), tag: 0)
        
        let secondVc = StartScheduleViewController()
        secondVc.presenter = StartSchedulePresenter(view: secondVc)
        secondVc.tabBarItem = UITabBarItem(title: "Расписание", image: UIImage(named: "Schedule.pdf"), tag: 1)
        
//        let thirdVc = StartMessagesViewController()
        let thirdVc = ProfileViewController()
        thirdVc.presenter = ProfilePresenter(view: thirdVc)
        thirdVc.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(named: "Messages.pdf"), tag: 2)
        
        let fourthVc = StartSettingsViewController()
        fourthVc.presenter = StartSettingsPresenter(view: fourthVc)
        fourthVc.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "Settings.pdf"), tag: 3)
        
        let controllerArray = [firstVc, secondVc, thirdVc, fourthVc]
        self.viewControllers = controllerArray.map { UINavigationController(rootViewController: $0) }
        
    }
    
}
