//
//  HubViewModel.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import Foundation

final class HubViewModel: ObservableObject {
    @Published var items: [HubItem] = []

    private let storageKey = "hub_items_order"

    private let defaultItems = [
        HubItem(
            icon: "mic.fill",
            title: "Speech to Text",
            subtitle: "Transcribe voice to text",
            destinationPage: .speechRecognition,
            enabled: true
        ),
        HubItem(
            icon: "star.fill",
            title: "Favorites",
            subtitle: "View saved items",
            destinationPage: .favourites,
            enabled: false
        ),
        HubItem(
            icon: "bell.fill",
            title: "Notifications",
            subtitle: "Recent alerts",
            destinationPage: .notifications,
            enabled: false
        ),
        HubItem(
            icon: "person.text.rectangle",
            title: "Author",
            subtitle: "Information about the author",
            destinationPage: .author,
            enabled: true
        ),
        HubItem(
            icon: "gearshape.fill",
            title: "Settings",
            subtitle: "Configure app",
            destinationPage: .settings,
            enabled: true
        ),
        HubItem(
            icon: "checklist",
            title: "Reminders",
            subtitle: "View and manage your personal reminders",
            destinationPage: .reminders,
            enabled: true
        ),
    ]

    // MARK: - Init
    init() {

        // Load stored order
        if let storedOrder = UserDefaults.standard.array(forKey: storageKey) as? [String] {
            var orderedItems: [HubItem] = []
            for idString in storedOrder {
                if let item = defaultItems.first(where: { $0.id == idString }) {
                    orderedItems.append(item)
                }
            }

            // Append any new items not in saved order
            let remainingItems = defaultItems.filter { item in
                !orderedItems.contains(where: { $0.id == item.id })
            }
            self.items = orderedItems + remainingItems
        } else {
            self.items = defaultItems
        }
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        persistOrder()
    }

    func resetOrder() {
        self.items = defaultItems
        persistOrder()
    }

    private func persistOrder() {
        UserDefaults.standard.set(
            items.map(\.id),
            forKey: storageKey
        )
    }
}
