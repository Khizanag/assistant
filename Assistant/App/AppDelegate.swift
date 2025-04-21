//
//  AppDelegate.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 15.04.25.
//

import Firebase
import FirebaseRemoteConfig
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
