import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.chetaru.notifications", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { (call, result) in
      if call.method == "areNotificationsEnabled" {
        self.areNotificationsEnabled { isEnabled in
          result(isEnabled)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func areNotificationsEnabled(completion: @escaping (Bool) -> Void) {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      DispatchQueue.main.async {
        // Returns true if authorized or provisional (provisional = temporarily allowed)
        let enabled = (settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional)
        completion(enabled)
      }
    }
  }
}

