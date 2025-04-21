//
//  AssistantApp.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

@main
struct AssistantApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var coordinator = Coordinator()
    @StateObject private var remoteConfig = AppRemoteConfig()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $coordinator.path) {
                    ContentView()
                        .navigationDestination(for: Page.self) { page in
                            coordinator.destination(for: page)
                        }
                }
                .environmentObject(coordinator)
                .environmentObject(remoteConfig)

                WatermarkView()
            }
            .onAppear {
                DispatchQueue.main.async {
                    remoteConfig.fetch()
                }
            }
        }
    }
}
