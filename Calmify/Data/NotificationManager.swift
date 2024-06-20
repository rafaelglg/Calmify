//
//  NotificationManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 18/6/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    var isNotification: Bool = false
    
    func requestAuthorization() {
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: options) { [weak self] success, error in
            if success {
                self?.isNotification = success
                print("Success: \(success.description)")
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Have 5 minutes to breathe"
        content.body = "Use Breather whenever you want"
        content.sound = .default
        content.badge = 1
        
        var date = DateComponents()
        date.hour = 15
        date.minute = 15
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Breathing", content: content, trigger: trigger)
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
