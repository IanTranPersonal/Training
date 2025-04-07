//
//  TrainingApp.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    PermissionsService.shared.requestNotificationPermission()
    FirebaseApp.configure()
    return true
  }
}

@main
struct TrainingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var base = Base.init(workoutDay: [])

    var body: some Scene {
        WindowGroup {
            HomePage().environmentObject(base)
        }
    }
}
