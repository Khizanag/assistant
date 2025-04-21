//
//  Coordinator.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    @ViewBuilder
    func destination(for page: Page) -> some View {
        switch page {
        case .author:
            AuthorView()
        case .favourites:
            Text("Favourites")
                .navigationTitle("Favourites")
        case .notifications:
            Text("Notifications")
                .navigationTitle("Notifications")
        case .settings:
            SettingsView()
        case .speechRecognition:
            SpeechRecognitionView()
        }
    }
}
