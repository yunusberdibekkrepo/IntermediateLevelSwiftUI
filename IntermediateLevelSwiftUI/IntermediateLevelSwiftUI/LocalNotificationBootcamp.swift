//
//  LocalNotificationBootcamp.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print(error.localizedDescription)
            } else {
                if success {
                    print("başarılı")
                }
            }
        }
    }

    func setBadge(badge: Int) {
        UNUserNotificationCenter.current().setBadgeCount(badge)
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "Subtitle"
        content.sound = .default
        content.badge = 1

        // trigger: time/calendar
        let timeTrigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5.0,
            repeats: false)

        // sunday monday tuesday wednesday thursday friday saturday
        let dateComponents = DateComponents(hour: 19, minute: 39, weekday: 3)
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: calendarTrigger)

        UNUserNotificationCenter.current().add(request)
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.shared.requestAuthorization()
            }

            Button("Schedule time notication") {
                NotificationManager.shared.scheduleNotification()
            }
        }
        .onAppear {
            NotificationManager.shared.setBadge(badge: 0)
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
