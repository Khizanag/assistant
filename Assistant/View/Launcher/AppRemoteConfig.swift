//
//  AppRemoteConfig.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 15.04.25.
//

import Firebase
import FirebaseRemoteConfig
import Foundation

final class AppRemoteConfig: ObservableObject {
    let remoteConfig: RemoteConfig

    @Published var hubTitle = "Hub"

    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    func fetch() {
        remoteConfig.fetch() { [weak self] status, error in
            guard let self else { return }
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { [weak self] changed, error in
                    guard let self else { return }
                    if let error {
                        print("Error activating remote config: \(error)")
                        return
                    }
                    print("Config activated!")

                    DispatchQueue.main.async {
                        self.hubTitle = self.remoteConfig.configValue(forKey: "hub_title").stringValue
                    }
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}
