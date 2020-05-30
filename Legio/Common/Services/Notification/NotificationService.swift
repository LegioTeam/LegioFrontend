//
//  NotificationService.swift
//  Legio
//
//  Created by Mac on 30.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import NotificationCenter

protocol NotificationService {
    func addNotification(for event: Event)
}

final class NotificationServiceImplementation: NotificationService {
    
    private enum Constants {
        static let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    }
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    
    func addNotification(for event: Event) {
        getCurrentNotificationStatus { [weak self] status in
            switch status {
            case .authorized, .provisional:
                self?.makeNotification(event: event)
            
            case .notDetermined:
                self?.requestForMakeNotification(event: event)
                
            default:
                return
            }
        }
    }
    
    
    //MARK: - Private methods
    
    /// Возвращает текущий статус разрешения получения уведомлений
    private func getCurrentNotificationStatus(
        completion: @escaping (UNAuthorizationStatus) -> Void) {
        
        notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    /// Отображает пользователю запрос на получение уведомлений
    private func makeNotificationRequest(
        completion: @escaping (Bool) -> Void) {
        
        notificationCenter.requestAuthorization(options: Constants.options) { granted, _ in
            completion(granted)
        }
    }
    
    /// Создает уведомление, с предварительным запросом разрешения
    private func requestForMakeNotification(event: Event) {
        
        makeNotificationRequest { [weak self] granted in
            if granted {
                self?.makeNotification(event: event)
            }
        }
    }
    
    /// Метод для создания уведомления
    private func makeNotification(event: Event) {
        
        guard let date = DateStringConverter.date(from: event.startsAt) else {
            return
        }
        
        let content = makeNotificationContent(for: event)
        let trigger = makeNotificationTrigger(for: date)
        let identifier = makeNotificationIdentifier(for: event)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    /// Метод для создания контента уведомления
    private func makeNotificationContent(for event: Event) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = event.name
        content.body = event.description
        content.sound = UNNotificationSound.default
        content.badge = 1
        return content
    }
    
    /// Метод для создания дата-триггера уведомления
    private func makeNotificationTrigger(for date: Date) -> UNNotificationTrigger {
        let previousDay = Date(timeInterval: -24*60*60, since: date)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: previousDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        return trigger
    }
    
    /// Метод для создания идентификатора уведомления
    private func makeNotificationIdentifier(for event: Event) -> String {
        return "Legio:\(event.id)"
    }
}

