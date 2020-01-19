//
//  NotificationDelegate.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 18.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (didAllow, _) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String?, description: String?, notifyDate: Date) {
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = title
        content.body = body ?? ""
        content.subtitle = description ?? ""
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: notifyDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Удалить", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActions,
                                              actions: [deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    //swiftlint:disable line_length
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}
