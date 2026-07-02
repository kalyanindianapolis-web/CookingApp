import Foundation
import UserNotifications

/// Schedules local notifications for cooking-mode step timers so they still
/// alert the user when the app is backgrounded (the in-app Combine timer is
/// suspended while the app isn't foreground).
enum CookTimerNotifier {
    /// Ask for permission once. Safe to call every time cooking mode appears.
    static func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    /// Schedules a notification `seconds` from now. Replaces any existing one
    /// with the same id.
    static func schedule(id: String, after seconds: Int, recipeName: String) {
        guard seconds > 0 else { return }
        let content = UNMutableNotificationContent()
        content.title = "Timer done — \(recipeName)"
        content.body = "Your step timer has finished."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.add(request)
    }

    static func cancel(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
