//
//  NotificationDelegate.swift
//  Legio
//
//  Created by Mikhail Semerikov on 29.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    func scheduleNotification(notificationType: String, dateComponents: DateComponents) {
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = "Как прошло?"
        content.body = notificationType
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = userActions
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)//Для отладки
//        var dateComponents = DateComponents()
//        dateComponents.hour = 11
//        dateComponents.minute = 15
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let showAction = UNNotificationAction(identifier: "Show", title: "Оценить", options: [.foreground])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Удалить", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActions,
                                              actions: [showAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.sound])
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
        case "Show":
            guard let controller = UIStoryboard(name: "Feedback", bundle: nil)
            .instantiateViewController(withIdentifier: FeedbackView.storyboardIdentifier) as? FeedbackView else { return }
            let assemler: FeedbackAssemblerProtocol = FeedbackAssembler()
            assemler.assemble(with: controller)
            controller.nameEvent = response.notification.request.content.body
            UIApplication.shared.keyWindow?.rootViewController!.show(controller, sender: nil)
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}
