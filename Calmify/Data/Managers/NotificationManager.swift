//
//  NotificationManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 18/6/24.
//

import Foundation
import UserNotifications

enum triggerType {
    case time
    case calendar
    
    var trigger : UNNotificationTrigger {
        switch self {
        case .time :
            return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        case .calendar :
            var date = DateComponents()
            date.hour = 09
            date.minute = 00
            return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        }
    }
}

final class NotificationManager {
    static let shared = NotificationManager()
    var isNotification: Bool = false
    
    func requestAuthorization() async throws {
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        
        do {
            let success = try await UNUserNotificationCenter.current().requestAuthorization(options: options)
            self.isNotification = success
        } catch {
            print(error.localizedDescription)
            throw ErrorManager.generalError(error: error )
        }
    }
    
    /// Schedule Notification every day at 9 am
    func scheduleNotification(trigger: triggerType, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: "Breathing", content: content, trigger: trigger.trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func RemoveDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func removeAll() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
