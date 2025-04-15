//
//  AssistantApp.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

@main
struct AssistantApp: App {

    @StateObject private var coordinator = Coordinator()

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

                WatermarkView()
            }
        }
    }
}
