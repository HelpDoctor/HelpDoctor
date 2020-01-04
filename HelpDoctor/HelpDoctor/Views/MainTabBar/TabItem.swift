//
//  TabItem.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 30.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//
/*
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
            viewController.presenter = StartMainPresenter(view: viewController)
            return viewController
        case .schedule:
            let viewController = StartScheduleViewController()
            //            viewController.presenter = StartSchedulePresenter(view: viewController)
            return viewController
        case .messages:
            let viewController = StartMessagesViewController()
            //            viewController.presenter = StartMessagesPresenter(view: viewController)
            return viewController
        case .settings:
            let viewController = StartSettingsViewController()
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
*/
