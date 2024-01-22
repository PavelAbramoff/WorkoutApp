//
//  Notifications.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2024-01-19.
//

import UIKit

class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    func rquestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            self.getNotificationSetting()
        }
    }
    
    func getNotificationSetting() {
        notificationCenter.getNotificationSettings { setting in
            print(setting)
        }
    }
    
    func scheduleDateNotification(date: Date, id: String) {
        
        let content = UNMutableNotificationContent()
        content.title = "WORCOUT"
        content.body = "Todey you have training"
        content.sound = .default
        content.badge = 1
        
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var triggerDate = calendar.dateComponents([.year, .month, .day
                                                  ], from: date)
        triggerDate.hour = 20
        triggerDate.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension Notifications: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound ])
        } else {
            completionHandler([.alert, .sound ])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        notificationCenter.removeAllDeliveredNotifications()
    }
}
