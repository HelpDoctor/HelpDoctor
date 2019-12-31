//
//  TabItem.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum TabItem: String, CaseIterable {
    case main = "главная"
    case schedule = "расписание"
    case messages = "сообщения"
    case settings = "настройки"
    
    
    var viewController: UIViewController {
        switch self {
        case .main:
            let viewController = StartMainViewController()
            let navigationController = UINavigationController()
            viewController.coordinator = StartMainCoordinator(navigationController: navigationController)
            viewController.presenter = StartMainPresenter(view: viewController)
            return viewController
        case .schedule:
            let viewController = StartScheduleViewController()
            let navigationController = UINavigationController()
//            viewController.coordinator = StartScheduleCoordinator(navigationController: navigationController)
//            viewController.presenter = StartSchedulePresenter(view: viewController)
            return viewController
        case .messages:
            let viewController = StartMessagesViewController()
            let navigationController = UINavigationController()
//            viewController.coordinator = StartMessagesCoordinator(navigationController: navigationController)
//            viewController.presenter = StartMessagesPresenter(view: viewController)
            return viewController
        case .settings:
            let viewController = StartSettingsViewController()
            let navigationController = UINavigationController()
//            viewController.coordinator = StartSettingsCoordinator(navigationController: navigationController)
//            viewController.presenter = StartSettingsPresenter(view: viewController)
            return viewController
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .main:
            let icon = "Main.pdf"
            guard let image = UIImage(named: icon) else {
                assertionFailure("Missing ​​\(icon) asset")
                return nil
            }
            return image
        case .schedule:
            let icon = "Schedule.pdf"
            guard let image = UIImage(named: icon) else {
                assertionFailure("Missing ​​\(icon) asset")
                return nil
            }
            return image
        case .messages:
            let icon = "Messages.pdf"
            guard let image = UIImage(named: icon) else {
                assertionFailure("Missing ​​\(icon) asset")
                return nil
            }
            return image
        case .settings:
            let icon = "Settings.pdf"
            guard let image = UIImage(named: icon) else {
                assertionFailure("Missing ​​\(icon) asset")
                return nil
            }
            return image
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
