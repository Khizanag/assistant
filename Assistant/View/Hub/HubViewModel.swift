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

    init() {
        let defaultItems = [
            HubItem(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                icon: "mic.fill",
                title: "Speech to Text",
                subtitle: "Transcribe voice to text",
                destinationPage: .speechRecognition,
                enabled: true
            ),
            HubItem(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
                icon: "star.fill",
                title: "Favorites",
                subtitle: "View saved items",
                destinationPage: .favourites,
                enabled: false
            ),
            HubItem(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
                icon: "bell.fill",
                title: "Notifications",
                subtitle: "Recent alerts",
                destinationPage: .notifications,
                enabled: false
            ),
            HubItem(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
                icon: "person.text.rectangle",
                title: "Author",
                subtitle: "Information about the author",
                destinationPage: .author,
                enabled: true
            ),
            HubItem(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
                icon: "gearshape.fill",
                title: "Settings",
                subtitle: "Configure app",
                destinationPage: .settings,
                enabled: true
            ),

        ]

        // Load stored order
        if let storedOrder = UserDefaults.standard.array(forKey: storageKey) as? [String] {
            var orderedItems: [HubItem] = []
            for idString in storedOrder {
                if let uuid = UUID(uuidString: idString),
                   let item = defaultItems.first(where: { $0.id == uuid }) {
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

    private func persistOrder() {
        let idStrings = items.map { $0.id.uuidString }
        UserDefaults.standard.set(idStrings, forKey: storageKey)
    }
}
